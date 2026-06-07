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

-- Intercept directory openings to show a blank file and the Neo-tree sidebar
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Check if Neovim was opened with a folder (e.g., `nvim .`)
    local path = vim.fn.argv(0)
    if type(path) == "string" and path ~= "" and vim.fn.isdirectory(path) == 1 then
      -- 1. Create a fresh, empty buffer in the main window
      vim.cmd("enew")

      -- 2. Find and delete the raw directory buffer that Neovim created
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if vim.fn.isdirectory(buf_name) == 1 then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end

      -- 3. Force Neo-tree to open as a proper sidebar
      vim.cmd("Neotree show")
    end
  end,
})
