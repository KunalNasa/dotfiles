-- In your init.lua or a dedicated plugin config file

-- vim.pack.add {
--   { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
-- }
vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

-- Setup mini.icons
require('mini.icons').setup {
  -- Optional: customize icon styles
  style = 'glyph', -- 'glyph' (default, needs Nerd Font) or 'ascii' (fallback)

  -- Optional: override specific icons
  -- file = {
  --   ['.gitignore'] = { glyph = '', hl = 'MiniIconsGrey' },
  -- },
  -- extension = {
  --   lua = { glyph = '󰢱', hl = 'MiniIconsAzure' },
  -- },
  directory = {
    ['default'] = { glyph = '󰉋', hl = 'MiniIconsGrey' }, -- default plain folder

    ['.git'] = { glyph = '', hl = 'MiniIconsOrange' }, -- git branch folder
    ['src'] = { glyph = '󱁿', hl = 'MiniIconsGreen' },
    ['node_modules'] = { glyph = '󰉗', hl = 'MiniIconsGrey' }, -- folder with package
    ['dist'] = { glyph = '󰈙', hl = 'MiniIconsYellow' }, -- folder with file
    ['test'] = { glyph = '󰙨', hl = 'MiniIconsPurple' }, -- folder with check
    ['tests'] = { glyph = '󰙨', hl = 'MiniIconsPurple' },
    ['__tests__'] = { glyph = '󰙨', hl = 'MiniIconsPurple' },
    ['docs'] = { glyph = '󰂺', hl = 'MiniIconsGrey' }, -- folder with book
    ['public'] = { glyph = '󰉒', hl = 'MiniIconsGreen' }, -- folder with globe
    ['config'] = { glyph = '󱁿', hl = 'MiniIconsGrey' }, -- folder with gear
    ['assets'] = { glyph = '󰉏', hl = 'MiniIconsYellow' }, -- folder with image
    ['components'] = { glyph = '󰕳', hl = 'MiniIconsAzure' }, -- folder with puzzle
    ['utils'] = { glyph = '󰛡', hl = 'MiniIconsYellow' }, -- folder with wrench
    ['types'] = { glyph = '󰎙', hl = 'MiniIconsCyan' }, -- folder with T
    ['hooks'] = { glyph = '󰋁', hl = 'MiniIconsPurple' }, -- folder with link
    ['store'] = { glyph = '󰆼', hl = 'MiniIconsOrange' }, -- folder with database
    ['api'] = { glyph = '󰒍', hl = 'MiniIconsGreen' }, -- folder with network
    ['lib'] = { glyph = '󰮩', hl = 'MiniIconsCyan' }, -- folder with book
    ['scripts'] = { glyph = '󰆍', hl = 'MiniIconsYellow' }, -- folder with terminal
  },
}

-- Optional but recommended: mock nvim-web-devicons so other plugins
-- (like mini.files, telescope, etc.) pick up mini.icons automatically
MiniIcons.mock_nvim_web_devicons()
