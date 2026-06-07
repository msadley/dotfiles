return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        -- Fallback order: LSP first, then treesitter, then indent
        return function(bufnr)
          return require("ufo").getFolds(bufnr, "lsp")
            :catch(function(err)
              return require("ufo").getFolds(bufnr, "treesitter")
            end)
            :catch(function(err)
              return require("ufo").getFolds(bufnr, "indent")
            end)
        end
      end,
      close_fold_kinds_for_ft = {
        default = { "imports" },
      },
    },
    init = function()
      -- Neovim options required by nvim-ufo
      vim.o.foldcolumn = "0"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close folds with" },
    },
  },
}
