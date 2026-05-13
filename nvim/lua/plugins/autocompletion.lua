-- Autocompletion

vim.pack.add({
  "https://github.com/hrsh7th/nvim-cmp",

  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",

  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
})

-- Build LuaSnip jsregexp support
if vim.fn.has("win32") == 0 and vim.fn.executable("make") == 1 then
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      local plugin_path = vim.fn.stdpath("data")
        .. "/site/pack/core/opt/LuaSnip"

      if vim.fn.isdirectory(plugin_path) == 1 then
        vim.fn.system({
          "make",
          "-C",
          plugin_path,
          "install_jsregexp",
        })
      end
    end,
  })
end

require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})

local kind_icons = {
  Text = "󰉿",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰆧",
  Class = "󰌗",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰇽",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- prevent continuous completion refreshes while typing fast
  completion = {
    autocomplete = {
      require("cmp.types").cmp.TriggerEvent.InsertEnter,
      require("cmp.types").cmp.TriggerEvent.TextChanged, -- triggers while typing
    },

    completeopt = "menu,menuone,noselect",

    keyword_length = 2, -- only trigger after 2 chars (reduces noise)
  },

  performance = {
    debounce = 150, -- wait 150ms after you stop typing (was 80, increase this)
    throttle = 60,
    fetching_timeout = 500,
    max_view_entries = 15, -- limit how many items render in the menu
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    ["<C-Space>"] = cmp.mapping.complete({}),

    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),

    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),

    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = {
    {
      name = "lazydev",
      group_index = 0,
    },

    { name = "nvim_lsp" },
    { name = "luasnip" },

    {
      name = "buffer",
      max_item_count = 5,
      keyword_length = 2,
    },

    { name = "path" },
  },

  formatting = {
    fields = {
      "kind",
      "abbr",
      "menu",
    },

    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]

      return vim_item
    end,
  },
})
