return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle",
  -- LazyVim's native event for loading plugins only when a real file is opened
  event = "LazyFile",
  opts = {
    enabled = true,

    -- Delay in milliseconds before saving
    debounce_delay = 1000,

    -- Which events to listen to
    trigger_events = { "InsertLeave", "TextChanged", "TextChangedI" },

    -- Conditions to check before saving
    condition = function(buf)
      local fn = vim.fn

      -- LazyVim specific filetypes to ignore
      local excluded_filetypes = {
        "TelescopePrompt",
        "NvimTree",
        "neo-tree",
        "gitcommit",
        "lazy",
        "mason",
        "trouble",
      }
      local current_filetype = fn.getbufvar(buf, "&filetype")

      -- 1. Do not save if buffer is not modifiable
      if fn.getbufvar(buf, "&modifiable") == 0 then
        return false
      end

      -- 2. Do not save if it is an unnamed, empty buffer
      if fn.bufname(buf) == "" then
        return false
      end

      -- 3. Do not save if it is in the excluded list
      if vim.tbl_contains(excluded_filetypes, current_filetype) then
        return false
      end

      return true
    end,
  },
  config = function(_, opts)
    require("auto-save").setup(opts)

    -- Create an augroup for the notifications
    local autosave_group = vim.api.nvim_create_augroup("autosave_notifications", { clear = true })

    -- 1. Message on save
    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveWritePost",
      group = autosave_group,
      callback = function(args)
        if args.data and args.data.saved_buffer ~= nil then
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(args.data.saved_buffer), ":t")
          -- Formatted for LazyVim's notification system
          vim.notify("Saved " .. filename, vim.log.levels.INFO, { title = "AutoSave" })
        end
      end,
    })

    -- 2. Message on enable
    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveEnable",
      group = autosave_group,
      callback = function()
        vim.notify("AutoSave enabled", vim.log.levels.INFO, { title = "AutoSave" })
      end,
    })

    -- 3. Message on disable
    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveDisable",
      group = autosave_group,
      callback = function()
        vim.notify("AutoSave disabled", vim.log.levels.WARN, { title = "AutoSave" })
      end,
    })
  end,
}
