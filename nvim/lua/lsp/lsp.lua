--[[
 NOTE:
    nvim-lspconfig will apply its default config for each enabled language server automatically.
    To extend a language server config, add your config to the `after/lsp` directory.
    The filename should be `[language_server_name].lua`
]]
vim.pack.add { { src = 'https://github.com/neovim/nvim-lspconfig' } }
vim.pack.add { { src = 'https://github.com/williamboman/mason.nvim' } }
require('mason').setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
}

vim.keymap.set('n', '<leader>mi', '<cmd>Mason<cr>', { desc = 'Mason Info' })

vim.pack.add { { src = 'https://github.com/williamboman/mason-lspconfig.nvim' } }

-- NOTE: mason-lspconfig will use mason to install the specified LSPs & then enable them
require('mason-lspconfig').setup {
  ensure_installed = {
    'ts_ls',
    'html',
    'cssls',
    'tailwindcss',
    'lua_ls',
    'graphql',
    'emmet_language_server',
    'prismals',
    'pyright',
    'dockerls',
    'sqlls',
    'jsonls',
    'yamlls',
    'mdx_analyzer',
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup {}
    end,
  },
}

local diagnostic_signs = {
  Error = ' ',
  Warn = ' ',
  Hint = '',
  Info = '',
}

vim.diagnostic.config {
  virtual_text = { prefix = '●', spacing = 4 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
      [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
      [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
      [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
    focusable = true, -- can select error messages from popup bar
    style = 'minimal',
  },
}

local telescope = require 'telescope.builtin'
--[[ add padding to the floating preview  ]]
do
  local orig = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'solid'
    opts.winhighlight = 'FloatBorder:NormalFloat'
    return orig(contents, syntax, opts, ...)
  end
end

-- LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }
    local keymap = vim.keymap

    -- ===========================
    -- telescope mappings
    -- ===========================
    opts.desc = 'Goto Definition'
    keymap.set('n', 'gd', function()
      telescope.lsp_definitions { reuse_win = true }
    end, opts)

    opts.desc = 'Goto Declaration'
    keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    opts.desc = 'References'
    keymap.set('n', 'gr', function()
      telescope.lsp_references { reuse_win = true }
    end, opts)

    opts.desc = 'Goto Implementation'
    keymap.set('n', 'gI', function()
      telescope.lsp_implementations { reuse_win = true }
    end, opts)

    opts.desc = 'Goto Type Definition'
    keymap.set('n', 'gt', function()
      telescope.lsp_type_definitions { reuse_win = true }
    end, opts)

    opts.desc = 'LSP Symbols'
    keymap.set('n', '<leader>sc', function()
      telescope.lsp_document_symbols()
    end, opts)

    opts.desc = 'LSP Workspace Symbols'
    keymap.set('n', '<leader>sS', function()
      telescope.lsp_dynamic_workspace_symbols()
    end, opts)

    opts.desc = 'Show buffer diagnostics'
    keymap.set('n', '<leader>D', function()
      telescope.diagnostics { bufnr = 0 }
    end, opts)

    -- ===========================
    -- native lsp & diagnostics mappings
    -- ===========================
    opts.desc = 'Goto Definition in vsplit'
    keymap.set('n', '<leader>gd', function()
      vim.cmd 'vsplit'
      vim.lsp.buf.definition()
    end, opts)

    opts.desc = 'See available code actions'
    keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

    opts.desc = 'Smart rename'
    keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    opts.desc = 'Go to previous diagnostic'
    keymap.set('n', '[d', function()
      vim.diagnostic.jump { count = -1, float = true }
    end, opts)

    opts.desc = 'Go to next diagnostic'
    keymap.set('n', ']d', function()
      vim.diagnostic.jump { count = 1, float = true }
    end, opts)

    -- focuses diagnostic float if already open
    vim.keymap.set('n', '<leader>d', function()
      if diag_float_win and vim.api.nvim_win_is_valid(diag_float_win) then
        vim.api.nvim_set_current_win(diag_float_win)
      else
        local _, win = vim.diagnostic.open_float()
        diag_float_win = win
      end
    end, { desc = 'Show Diagnostics' })

    opts.desc = 'Open diagnostics list'
    keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

    opts.desc = 'Show documentation for what is under cursor'
    keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    opts.desc = 'Restart LSP'
    keymap.set('n', '<leader>rs', ':lsp restart<CR>', opts)

    -- ===========================
    -- conditional mappings (capabilities check)
    -- ===========================
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    if client:supports_method('textDocument/callHierarchy', ev.buf) then
      opts.desc = 'Calls Incoming'
      keymap.set('n', 'gai', function()
        vim.lsp.buf.incoming_calls()
      end, opts)

      opts.desc = 'Calls Outgoing'
      keymap.set('n', 'gao', function()
        vim.lsp.buf.outgoing_calls()
      end, opts)
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, ev.buf) then
      opts.desc = 'Toggle Inlay Hints'
      keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf })
      end, opts)
    end

    if client:supports_method('textDocument/codeAction', ev.buf) then
      opts.desc = 'Organize Imports'
      keymap.set('n', '<leader>oi', function()
        vim.lsp.buf.code_action {
          context = { only = { 'source.organizeImports' }, diagnostics = {} },
          apply = true,
          bufnr = ev.buf,
        }
        vim.defer_fn(function()
          vim.lsp.buf.format { bufnr = ev.buf }
        end, 50)
      end, opts)
    end
  end,
})
