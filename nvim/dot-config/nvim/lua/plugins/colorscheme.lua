return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    local generated = vim.fs.normalize("~/.local/state/caelestia/theme/nvim.lua")
    if vim.uv.fs_stat(generated) then
      dofile(generated)
    else
      vim.cmd("colorscheme rose-pine")
    end
  end
}
