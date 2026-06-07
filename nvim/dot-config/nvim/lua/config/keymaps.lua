-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function get_main_win()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local current_ft = vim.bo[current_buf].filetype
  local current_bt = vim.bo[current_buf].buftype

  if current_ft ~= "neo-tree" and current_ft ~= "snacks_dashboard" and current_ft ~= "alpha" and current_bt == "" then
    return current_win
  end

  -- Find the first window that is not a sidebar or special window
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    local bt = vim.bo[buf].buftype
    if ft ~= "neo-tree" and ft ~= "snacks_dashboard" and ft ~= "alpha" and bt == "" and vim.api.nvim_win_get_config(win).relative == "" then
      return win
    end
  end
  return current_win
end

-- Toggle Global Terminal (<leader>ft)
vim.keymap.set("n", "<leader>ft", function()
  local main_win = get_main_win()
  local terminal = Snacks.terminal.get(nil, {
    id = "global_term",
    create = false,
  })
  if terminal then
    terminal.opts.relative = "win"
    terminal.opts.win = main_win
  end

  local trouble = require("trouble")
  if trouble.is_open() then
    trouble.close()
    if not (terminal and terminal:valid()) then
      Snacks.terminal(nil, {
        id = "global_term",
        win = {
          position = "bottom",
          relative = "win",
          win = main_win,
          wo = { winbar = "" },
          bo = { buflisted = false },
        },
      })
    end
  else
    Snacks.terminal(nil, {
      id = "global_term",
      win = {
        position = "bottom",
        relative = "win",
        win = main_win,
        wo = { winbar = "" },
        bo = { buflisted = false },
      },
    })
  end
end, { desc = "Toggle Global Terminal" })

-- Toggle Problems Panel (<leader>fy)
vim.keymap.set("n", "<leader>fy", function()
  local main_win = get_main_win()
  local terminal = Snacks.terminal.get(nil, {
    id = "global_term",
    create = false,
  })

  local trouble = require("trouble")
  if terminal and terminal:valid() then
    terminal:hide()
    if not trouble.is_open() then
      vim.api.nvim_win_call(main_win, function()
        trouble.open({
          mode = "diagnostics",
          win = {
            position = "bottom",
            relative = "win",
            type = "split",
            size = 0.3,
          },
        })
      end)
    end
  else
    vim.api.nvim_win_call(main_win, function()
      trouble.toggle({
        mode = "diagnostics",
        win = {
          position = "bottom",
          relative = "win",
          type = "split",
          size = 0.3,
        },
      })
    end)
  end
end, { desc = "Toggle Problems Panel" })
