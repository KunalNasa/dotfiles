local augroup = vim.api.nvim_create_augroup('GlobalFormatOnSave', {})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype

    vim.lsp.buf.format {
      bufnr = bufnr,
      async = false,
      filter = function(client)
        if ft == 'rust' then
          return client.name == 'rust_analyzer'
        end
        return client.name == 'null-ls'
      end,
    }
  end,
})
