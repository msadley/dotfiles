return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.disabled_filetypes = opts.options.disabled_filetypes or {}

      -- Impede que a winbar apareça sobre a barra lateral do Neo-tree
      opts.options.disabled_filetypes.winbar = {
        "neo-tree",
        "snacks_dashboard",
        "alpha",
        "lazy",
        "mason",
      }

      opts.winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "buffers",
            show_filename_only = true,
            show_modified_status = true,
            mode = 0,

            -- Oculta o conteúdo se houver apenas um arquivo vazio
            cond = function()
              local bufs = vim.fn.getbufinfo({ buflisted = 1 })
              if #bufs == 1 and bufs[1].name == "" and bufs[1].changed == 0 then
                return false
              end
              return true
            end,

            -- Estilo "aba clássica" com blocos largos
            fmt = function(name, context)
              return "  " .. name .. "  "
            end,

            -- Usa as cores dinâmicas do seu tema
            buffers_color = {
              active = "TabLineSel",
              inactive = "TabLine",
            },

            symbols = {
              modified = " ●",
              alternate_file = "",
              directory = "",
            },
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }

      opts.inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "buffers",
            show_filename_only = true,
            show_modified_status = true,
            mode = 0,

            cond = function()
              local bufs = vim.fn.getbufinfo({ buflisted = 1 })
              if #bufs == 1 and bufs[1].name == "" and bufs[1].changed == 0 then
                return false
              end
              return true
            end,

            fmt = function(name, context)
              return "  " .. name .. "  "
            end,

            buffers_color = {
              active = "TabLineSel",
              inactive = "TabLine",
            },

            symbols = {
              modified = " ●",
              alternate_file = "",
              directory = "",
            },
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }
    end,
  },
}
