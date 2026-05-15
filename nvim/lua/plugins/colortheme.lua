vim.pack.add {
  'https://github.com/projekt0n/github-nvim-theme',
}

require('github-theme').setup {
  options = {
    -- updated style settings
    styles = {
      comments = 'NONE',
      keywords = 'NONE',
      functions = 'NONE',
      variables = 'NONE',
    },

    -- updated darken options
    darken = {
      sidebars = {
        enable = true,
      },
      floats = true,
    },
  },
}

-- -- now you pick the variant using colorscheme only
vim.cmd.colorscheme 'github_dark_dimmed'

-- Tokyo Night theme
-- vim.pack.add {
--   'https://github.com/catppuccin/nvim',
-- }
--
-- require('catppuccin').setup {
--   flavour = 'mocha', -- latte, frappe, macchiato, mocha
--
--   background = { -- configure background per mode
--     light = 'latte',
--     dark = 'mocha',
--   },
--
--   transparent_background = false,
--   show_end_of_buffer = false,
--
--   integrations = {
--     -- enable plugins integration if you want
--     lsp_trouble = true,
--     nvimtree = true,
--     snacks = true,
--     cmp = true,
--     gitsigns = true,
--     -- add more as needed
--   },
-- }
--
-- -- -- set the colorscheme
-- vim.cmd.colorscheme 'catppuccin'
--
-- vim.pack.add {
--   'https://github.com/folke/tokyonight.nvim',
-- }
--
-- require('tokyonight').setup {
--   style = 'night', -- storm, moon, night, day
--   transparent = false,
-- }
--
-- vim.cmd.colorscheme 'tokyonight'

-- vim.pack.add {
--   'https://github.com/EdenEast/nightfox.nvim',
-- }
--
-- require('nightfox').setup()
--
-- vim.cmd.colorscheme 'Nordfox'
