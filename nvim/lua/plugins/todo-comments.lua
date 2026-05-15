vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/folke/todo-comments.nvim',
}

require('todo-comments').setup {
  signs = false,

  colors = {
    soft_yellow = { '#f9e2af' },
    soft_blue = { '#5eb5a5' },
  },

  keywords = {

    NOTE = {
      color = 'soft_yellow',
    },

    TODO = {
      color = 'soft_blue',
    },
  },
}
