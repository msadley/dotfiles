-- Override nvim_strwidth to correctly calculate display width of statusline strings containing %#Group# tags
local original_strwidth = vim.api.nvim_strwidth
vim.api.nvim_strwidth = function(str)
  if type(str) == "string" and str:match("%%#") then
    local stripped = str:gsub("%%#[^#]*#", "")
    return original_strwidth(stripped)
  end
  return original_strwidth(str)
end

return {
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.offsets = opts.options.offsets or {}
      opts.options.show_buffer_close_icons = false
      opts.options.show_close_icon = false
      opts.options.max_name_length = 30

      -- Filter out directory buffers from showing up in the bufferline tabs
      local original_filter = opts.options.custom_filter
      opts.options.custom_filter = function(buf, buf_nums)
        if original_filter and not original_filter(buf, buf_nums) then
          return false
        end
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name ~= "" and vim.fn.isdirectory(buf_name) == 1 then
          return false
        end
        return true
      end

      -- Create custom highlight groups to match Neo-tree root node colors
      local function set_offset_hl()
        local normal_hl = vim.api.nvim_get_hl(0, { name = "NeoTreeNormal" })
        if not normal_hl.bg then
          normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
        end
        local root_hl = vim.api.nvim_get_hl(0, { name = "NeoTreeRootName" })
        local directory_hl = vim.api.nvim_get_hl(0, { name = "Directory" })

        -- Text highlight (off-white, bold, custom bg)
        vim.api.nvim_set_hl(0, "BufferLineNeoTreeOffset", {
          fg = root_hl.fg or normal_hl.fg,
          bg = normal_hl.bg,
          bold = true,
        })

        -- Icon highlight (orange, custom bg)
        vim.api.nvim_set_hl(0, "BufferLineNeoTreeIcon", {
          fg = directory_hl.fg,
          bg = normal_hl.bg,
        })
      end

      set_offset_hl()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_offset_hl,
      })

      -- Text formatter that handles padding, icon colors, and smart truncation
      local function get_offset_text()
        local cwd = vim.fn.getcwd()
        local path = vim.fn.fnamemodify(cwd, ":~")

        -- Find the active neo-tree window to get its current width dynamically
        local win_id = nil
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "neo-tree" then
            win_id = win
            break
          end
        end

        local width = win_id and vim.api.nvim_win_get_width(win_id) or 30
        -- We want the visual text to fit in width - 2 (leaving 1 space padding on left/right)
        local limit = width - 2
        -- The icon ("") and the space after it take 2 cells
        local path_limit = limit - 2
        if path_limit < 10 then path_limit = 10 end

        -- If the path exceeds the limit, truncate from the left (showing tail) and prepend "..."
        if original_strwidth(path) > path_limit then
          local ellipsis = "..."
          local parts = vim.split(path, "/")
          local truncated = ""
          for i = #parts, 1, -1 do
            local candidate = parts[i] .. (truncated ~= "" and ("/" .. truncated) or "")
            if original_strwidth(ellipsis .. "/" .. candidate) <= path_limit then
              truncated = candidate
            else
              if truncated == "" then
                local char_len = vim.fn.strchars(parts[i])
                truncated = vim.fn.strcharpart(parts[i], char_len - path_limit + 4)
              end
              break
            end
          end
          path = ellipsis .. "/" .. truncated
        end

        return "%#BufferLineNeoTreeIcon#" .. string.char(238, 151, 190) .. "%#BufferLineNeoTreeOffset# " .. path
      end

      local found = false
      for _, offset in ipairs(opts.options.offsets) do
        if offset.filetype == "neo-tree" then
          offset.text = get_offset_text
          offset.highlight = "BufferLineNeoTreeOffset"
          offset.text_align = "left"
          offset.separator = true
          found = true
          break
        end
      end

      if not found then
        table.insert(opts.options.offsets, {
          filetype = "neo-tree",
          text = get_offset_text,
          highlight = "BufferLineNeoTreeOffset",
          text_align = "left",
          separator = true,
        })
      end
    end,
  },
}
