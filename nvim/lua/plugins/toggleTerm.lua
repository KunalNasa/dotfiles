vim.pack.add {
  'https://github.com/akinsho/toggleterm.nvim',
}

require('toggleterm').setup {
  direction = 'float',

  float_opts = {
    border = 'curved',
  },
}

-- Open with Ctrl+J (normal mode)
vim.keymap.set('n', '<C-j>', '<cmd>ToggleTerm<CR>', {
  desc = 'Open terminal',
  noremap = true,
  silent = true,
})

-- Close with double Escape (terminal mode)
vim.keymap.set('t', '<Esc><Esc>', '<cmd>ToggleTerm<CR>', {
  desc = 'Close terminal',
  noremap = true,
  silent = true,
})
