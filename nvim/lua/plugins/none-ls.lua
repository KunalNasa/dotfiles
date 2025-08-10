
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- Install formatters & linters via Mason
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier',
        'stylua',
        'eslint_d',
        'shfmt',
        'checkmake',
        'ruff',
      },
      automatic_installation = true,
    }

    local sources = {
      -- LINTERS
      diagnostics.checkmake,
      require("none-ls.diagnostics.eslint_d"),

      -- FORMATTERS
      formatting.prettier.with {
        filetypes = {
          'javascript',
          'typescript',
          'javascriptreact',
          'typescriptreact',
          'json',
          'yaml',
          'markdown',
          'html',
        },
        extra_args = { '--plugin', 'prettier-plugin-organize-imports' },
      },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
      -- Optional: ESLint as a formatter (if you want it)
      -- require("none-ls.formatting.eslint_d"),
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    null_ls.setup {
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end

        -- Optional: run diagnostics again on save
        if client.supports_method 'textDocument/diagnostic' then
          vim.api.nvim_create_autocmd('BufWritePost', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              require('none-ls').try_lsp_diagnostic(bufnr)
            end,
          })
        end
      end,
    }
  end,
}
