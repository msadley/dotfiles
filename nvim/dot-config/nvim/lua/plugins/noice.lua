return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.routes = opts.routes or {}

    table.insert(opts.routes, {
      filter = {
        event = "lsp",
        kind = "progress",
        cond = function(message)
          local client = vim.tbl_get(message.opts, "progress", "client")
          return client == "jdtls"
        end,
      },
      opts = { skip = true },
    })

    table.insert(opts.routes, {
      filter = {
        event = "msg_show",
        any = {
          { find = "Validate documents" },
        },
      },
      opts = { skip = true },
    })
  end,
}
