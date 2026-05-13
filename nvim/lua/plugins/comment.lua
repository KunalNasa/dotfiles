-- Easily comment visual regions/lines

vim.pack.add {
  'https://github.com/numToStr/Comment.nvim',
}

require('Comment').setup {}

local opts = {
  noremap = true,
  silent = true,
  desc = 'Toggle comment',
}

vim.keymap.set('n', '<C-_>', require('Comment.api').toggle.linewise.current, opts)
vim.keymap.set('n', '<C-c>', require('Comment.api').toggle.linewise.current, opts)
vim.keymap.set('n', '<C-/>', require('Comment.api').toggle.linewise.current, opts)
vim.keymap.set('v', '<C-_>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
vim.keymap.set('v', '<C-c>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
vim.keymap.set('v', '<C-/>', "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
