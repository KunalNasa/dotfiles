-- Standalone plugins with less than 10 lines of config go here

vim.pack.add {
  -- Tmux & split window navigation
  -- "https://github.com/christoomey/vim-tmux-navigator",

  -- Detect tabstop and shiftwidth automatically
  'https://github.com/tpope/vim-sleuth',

  -- Powerful Git integration for Vim
  'https://github.com/tpope/vim-fugitive',

  -- GitHub integration for vim-fugitive
  'https://github.com/tpope/vim-rhubarb',

  -- Hints keybinds
  'https://github.com/folke/which-key.nvim',

  -- Autoclose parentheses, brackets, quotes, etc.
  'https://github.com/windwp/nvim-autopairs',

  -- High-performance color highlighter
  'https://github.com/norcalli/nvim-colorizer.lua',

  -- Smooth scrolling for window movement commands (Ctrl-D, Ctrl-U, etc.)
  'https://github.com/karb94/neoscroll.nvim',
}

require('nvim-autopairs').setup {}

require('colorizer').setup()

require('neoscroll').setup {
  -- Exclude C-u and C-d from default setup so we can override their speed
  mappings = {
    '<C-b>',
    '<C-f>',
    '<C-y>',
    '<C-e>',
    'zt',
    'zz',
    'zb',
  },
}

local neoscroll = require 'neoscroll'
local keymap = vim.keymap

-- Custom mapping using the new helper functions
keymap.set({ 'n', 'v', 'x' }, '<C-u>', function()
  neoscroll.ctrl_u {
    duration = 80,
  }
end)

keymap.set({ 'n', 'v', 'x' }, '<C-d>', function()
  neoscroll.ctrl_d {
    duration = 80,
  }
end)
