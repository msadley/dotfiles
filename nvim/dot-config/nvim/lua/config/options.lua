-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.colors_name = "ayu"
vim.o.background = "dark"
vim.opt.relativenumber = false

-- Disable default trouble statusline to customize it in lualine.lua
vim.g.trouble_lualine = false

-- Enable both English and Portuguese spell checking
vim.opt.spelllang = { "en", "pt" }
