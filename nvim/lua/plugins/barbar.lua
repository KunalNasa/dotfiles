vim.pack.add {
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/romgrk/barbar.nvim',
}

vim.g.barbar_auto_setup = false -- disable auto setup

require('barbar').setup {
  animation = true,
}
