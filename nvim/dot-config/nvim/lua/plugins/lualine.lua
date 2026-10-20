return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.disabled_filetypes = opts.options.disabled_filetypes or {}

      -- Impede que a winbar apareça sobre a barra lateral do Neo-tree e em terminais
      opts.options.disabled_filetypes.winbar = {
        "neo-tree",
        "snacks_dashboard",
        "snacks_terminal", -- Oculta no terminal do Snacks (padrão atual do LazyVim)
        "toggleterm", -- Oculta no terminal do ToggleTerm
        "terminal", -- Oculta em terminais genéricos do Neovim
        "alpha",
        "lazy",
        "mason",
      }

      -- Adiciona o trouble symbols com formato customizado sem :Normal para evitar coloração de fundo incorreta
      if LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and function()
            local status = symbols.get()
            if type(status) == "string" then
              return status:gsub("%%%*", "%%#lualine_c_normal#")
            end
            return status
          end,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      -- Tabs indicator aligned to the right (lualine_z is the far-right section).
      -- Hidden when there is only one tab; bufferline (top) is left untouched.
      opts.sections = opts.sections or {}
      opts.sections.lualine_z = opts.sections.lualine_z or {}
      table.insert(opts.sections.lualine_z, {
        "tabs",
        mode = 2,
        max_length = vim.o.columns * 2 / 5,
        use_mode_colors = false,
        show_modified_status = true,
        symbols = { modified = " ●" },
        cond = function()
          return #vim.api.nvim_list_tabpages() > 1
        end,
      })
    end,
  },
}
