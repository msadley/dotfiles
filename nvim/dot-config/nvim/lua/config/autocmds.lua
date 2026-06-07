-- Guard against invalid window ID errors when plugins try to focus closed/deleted windows
local original_set_current_win = vim.api.nvim_set_current_win
vim.api.nvim_set_current_win = function(win)
  if vim.api.nvim_win_is_valid(win) then
    pcall(original_set_current_win, win)
  end
end

-- Clean empty buffers when opening a file
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("CleanEmptyBuffers", { clear = true }),
  callback = function(args)
    local filetype = vim.bo[args.buf].filetype
    local buftype = vim.bo[args.buf].buftype
    if buftype ~= "" or filetype == "neo-tree" or filetype == "snacks_dashboard" or filetype == "alpha" then
      return
    end

    local is_empty_buffer = function(bufnr)
      local buf_name = vim.api.nvim_buf_get_name(bufnr)
      local buf_type = vim.bo[bufnr].buftype
      local is_modified = vim.bo[bufnr].modified

      if buf_name == "" and buf_type == "" and not is_modified then
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        if #lines == 1 and lines[1] == "" then
          return true
        end
      end
      return false
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= args.buf and vim.api.nvim_buf_is_valid(buf) and is_empty_buffer(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})

-- Aggressively hide the winbar and unlist the buffer for ALL terminal windows
vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    -- Check if the current buffer is a terminal
    if vim.bo.buftype == "terminal" then
      vim.opt_local.winbar = ""
      vim.bo.buflisted = false
    end
  end,
})

-- Open Neo-tree by default on startup and when switching projects (directory changes)
vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  group = vim.api.nvim_create_augroup("NeoTreeOpenOnStartup", { clear = true }),
  callback = function(args)
    local event = args.event
    local is_diff = vim.opt.diff:get()

    vim.schedule(function()
      -- If event is VimEnter, handle directory arguments
      if event == "VimEnter" then
        -- Check if Neovim was opened with a folder (e.g., `nvim .` or `nvim ~/project`)
        local path = vim.fn.argv(0)
        local is_dir = type(path) == "string" and path ~= "" and vim.fn.isdirectory(path) == 1

        if is_dir then
          -- Resolve absolute path and change directory to it
          local abs_path = vim.fn.fnamemodify(path, ":p")
          if #abs_path > 1 and abs_path:sub(-1) == "/" then
            abs_path = abs_path:sub(1, -2)
          end
          vim.fn.chdir(abs_path)

          -- 1. Create a fresh, empty buffer in the main window
          vim.cmd("enew")

          -- 2. Find and delete the raw directory buffer that Neovim created
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if buf_name ~= "" and (buf_name == abs_path or buf_name .. "/" == abs_path or vim.fn.isdirectory(buf_name) == 1) then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end

          -- Show Neo-tree sidebar on the target folder and exit
          vim.cmd("Neotree show dir=" .. vim.fn.fnameescape(abs_path))
          return
        end
      end

      -- Check if we are in diff mode, or editing git commit/rebase messages
      if is_diff then
        return
      end

      local filetype = vim.bo.filetype
      if filetype == "gitcommit" or filetype == "gitrebase" then
        return
      end

      -- Also check if the buffer is a special type (only on VimEnter)
      if event == "VimEnter" then
        if vim.bo.buftype == "nofile" or vim.bo.buftype == "quickfix" then
          return
        end
      end

      -- Show Neo-tree sidebar for file openings, empty startup, or project switching
      if event == "VimEnter" then
        local path = vim.fn.argv(0)
        local is_file = type(path) == "string" and path ~= "" and vim.fn.isdirectory(path) == 0
        if is_file then
          local root = nil
          if _G.LazyVim and _G.LazyVim.root and _G.LazyVim.root.get then
            root = _G.LazyVim.root.get()
          end
          if not root or root == "" or root == vim.fn.expand("$HOME") then
            root = vim.fn.fnamemodify(path, ":p:h")
          end
          vim.cmd("Neotree reveal dir=" .. vim.fn.fnameescape(root))
          return
        end
      end

      vim.cmd("Neotree show")
    end)
  end,
})

-- Dynamically toggle neo-tree root visibility based on the number of open listed buffers
local function count_listed_buffers()
  local count = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buflisted and vim.api.nvim_buf_is_valid(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      local ft = vim.bo[buf].filetype
      local bt = vim.bo[buf].buftype
      if ft ~= "neo-tree" and ft ~= "snacks_dashboard" and ft ~= "alpha" and bt == "" and name ~= "" then
        count = count + 1
      end
    end
  end
  return count
end

local function is_neotree_visible()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "neo-tree" then
      return true
    end
  end
  return false
end

local function update_neotree_root_visibility()
  local neotree_ok, neotree = pcall(require, "neo-tree")
  if not neotree_ok then return end

  local count = count_listed_buffers()
  local should_hide = count > 1

  if neotree.config and neotree.config.hide_root_node ~= should_hide then
    neotree.config.hide_root_node = should_hide
    if is_neotree_visible() then
      local manager_ok, manager = pcall(require, "neo-tree.sources.manager")
      if manager_ok then
        manager.refresh("filesystem")
      end
    end
  end
end

vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("NeoTreeCwdAutoToggle", { clear = true }),
  callback = function()
    -- Defer execution by 50ms to let any file-opening operations finish first
    vim.defer_fn(update_neotree_root_visibility, 50)
  end,
})

-- Automatically unlist directory buffers to prevent them from showing up as tabs in bufferline
vim.api.nvim_create_autocmd({ "BufAdd", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("UnlistDirectoryBuffers", { clear = true }),
  callback = function(args)
    local buf_name = vim.api.nvim_buf_get_name(args.buf)
    if buf_name ~= "" and vim.fn.isdirectory(buf_name) == 1 then
      vim.bo[args.buf].buflisted = false
    end
  end,
})


