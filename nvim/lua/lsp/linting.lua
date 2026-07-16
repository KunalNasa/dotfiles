vim.pack.add({
	"https://github.com/nvimtools/none-ls.nvim",

	-- dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvimtools/none-ls-extras.nvim",
	"https://github.com/jay-babu/mason-null-ls.nvim",
	"https://github.com/neovim/nvim-lspconfig",
})

require("mason-null-ls").setup({
	ensure_installed = {
		"checkmake",
		"eslint_d",
		"oxlint",
	},
	automatic_installation = true,
})

local null_ls = require("null-ls")

local eslint_markers = {
	".eslintrc",
	".eslintrc.js",
	".eslintrc.cjs",
	".eslintrc.json",
	"eslint.config.js",
	"eslint.config.mjs",
}

-- NOTE: the setup of following linters is handled by `nvim-lspconfig`:
--  oxlint
--  biome

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.checkmake,

		-- eslint: only if eslint config found in root
		require("none-ls.diagnostics.eslint_d").with({
			condition = function(utils)
				return utils.root_has_file(eslint_markers)
			end,
		}),
		require("none-ls.code_actions.eslint_d").with({
			condition = function(utils)
				return utils.root_has_file(eslint_markers)
			end,
		}),
	},
})

