-- Clean empty buffers when opening a file
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("CleanEmptyBuffers", { clear = true }),
  callback = function(args)
    local filetype = vim.bo[args.buf].filetype
    if filetype == "neo-tree" or filetype == "snacks_dashboard" or filetype == "alpha" then
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
