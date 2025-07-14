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
}
