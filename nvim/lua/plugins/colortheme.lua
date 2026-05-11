return {
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
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

      -- now you pick the variant using colorscheme only
      vim.cmd 'colorscheme github_dark_dimmed'
    end,
  },
  -- TRIED THIS BELOW THEME BUT DIDN'T LIKE IT MUCH
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   lazy = false, -- load immediately
  --   priority = 1000, -- make sure it loads first
  --   config = function()
  --     require('catppuccin').setup {
  --       flavour = 'mocha', -- latte, frappe, macchiato, mocha
  --       background = { -- configure background per mode
  --         light = 'latte',
  --         dark = 'mocha',
  --       },
  --       transparent_background = false,
  --       show_end_of_buffer = false,
  --       integrations = {
  --         -- enable plugins integration if you want
  --         lsp_trouble = true,
  --         nvimtree = true,
  --         telescope = true,
  --         cmp = true,
  --         gitsigns = true,
  --         -- add more as needed
  --       },
  --     }
  --
  --     -- set the colorscheme
  --     vim.cmd 'colorscheme catppuccin'
  --   end,
  -- },
}
