-- Highlight, edit, and navigate code

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/windwp/nvim-ts-autotag",
})

vim.api.nvim_create_autocmd("PackChanged", {
  once = true,
  callback = function()
    require("nvim-ts-autotag").setup()

    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "vimdoc",
        "vim",
        "regex",
        "terraform",
        "sql",
        "dockerfile",
        "toml",
        "json",
        "java",
        "groovy",
        "go",
        "gitignore",
        "graphql",
        "yaml",
        "make",
        "cmake",
        "markdown",
        "markdown_inline",
        "bash",
        "css",
        "jsdoc",
      },

      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {
          "ruby",
        },
      },

      indent = {
        enable = true,
        disable = {
          "ruby",
        },
      },
    })

    vim.cmd("TSUpdate")
  end,
})