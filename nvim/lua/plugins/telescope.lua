vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
}

if vim.g.have_nerd_font then
  vim.pack.add {
    'https://github.com/nvim-tree/nvim-web-devicons',
  }
end

if vim.fn.executable 'make' == 1 then
  vim.pack.add {
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  }
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    if vim.fn.executable 'make' == 1 then
      local plugin_path = vim.fn.stdpath 'data' .. '/site/pack/core/opt/telescope-fzf-native.nvim'

      if vim.fn.isdirectory(plugin_path) == 1 then
        vim.fn.system {
          'make',
          '-C',
          plugin_path,
        }
      end
    end
  end,
})

local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    sorting_strategy = 'ascending',

    layout_strategy = 'horizontal',

    layout_config = {
      horizontal = {
        width = 0.95,
        height = 0.95,
        preview_width = 0.60,
        prompt_position = 'top',
      },
    },

    mappings = {
      i = {
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-l>'] = actions.select_default,
      },
    },
  },

  pickers = {
    find_files = {
      hidden = true,
    },
    file_ignore_patterns = {
      'node_modules/',
      '.git/',
      '.next/',
      '.turbo/',
      '.venv/',
      'dist/',
      'build/',
      'coverage/',
      'pnpm%-lock%.yaml',
      'package%-lock%.json',
      'bun%.lock',
    },

    live_grep = {
      additional_args = function()
        return {
          '--hidden',
          '--glob=!**/.git/*',
          '--glob=!**/.next/*',
          '--glob=!**/.turbo/*',
          '--glob=!**/node_modules/*',
          '--glob=!**/.venv/*',
          '--glob=!**/dist/*',
          '--glob=!**/build/*',
          '--glob=!**/coverage/*',
          '--glob=!**/pnpm-lock.yaml',
          '--glob=!**/package-lock.json',
          '--glob=!**/bun.lock',
        }
      end,
    },
  },

  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
  desc = '[S]earch [H]elp',
})

vim.keymap.set('n', '<leader>sk', builtin.keymaps, {
  desc = '[S]earch [K]eymaps',
})

vim.keymap.set('n', '<leader>sf', builtin.find_files, {
  desc = '[S]earch [F]iles',
})

vim.keymap.set('n', '<leader>ss', builtin.builtin, {
  desc = '[S]earch [S]elect Telescope',
})

vim.keymap.set('n', '<leader>sw', builtin.grep_string, {
  desc = '[S]earch current [W]ord',
})

vim.keymap.set('n', '<leader>sg', builtin.live_grep, {
  desc = '[S]earch by [G]rep',
})

vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {
  desc = '[S]earch [D]iagnostics',
})

vim.keymap.set('n', '<leader>sr', builtin.resume, {
  desc = '[S]earch [R]esume',
})

vim.keymap.set('n', '<leader>s.', builtin.oldfiles, {
  desc = '[S]earch Recent Files ("." for repeat)',
})

vim.keymap.set('n', '<leader><leader>', builtin.buffers, {
  desc = '[ ] Find existing buffers',
})

vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find {
    sorting_strategy = 'ascending',

    layout_strategy = 'horizontal',

    layout_config = {
      horizontal = {
        width = 0.95,
        height = 0.95,
        preview_width = 0.60,
        prompt_position = 'top',
      },
    },
  }
end, {
  desc = '[/] Fuzzily search in current buffer',
})

vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, {
  desc = '[S]earch [/] in Open Files',
})
