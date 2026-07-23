vim.pack.add({
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lua" },
  { src = "https://github.com/hrsh7th/cmp-calc" },
  { src = "https://github.com/hrsh7th/cmp-emoji" },
  { src = "https://github.com/uga-rosa/cmp-dictionary" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },

  -- UI
  { src = "https://github.com/onsails/lspkind.nvim" },

  -- Sorting
  { src = "https://github.com/lukas-reineke/cmp-under-comparator" },
})

vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "path" },
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "calc" },
    { name = "emoji" },
  }),

  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 40,
    }),
  },

  sorting = {
    comparators = {
      require("cmp-under-comparator").under,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

require("cmp_dictionary").setup({
  paths = {
    vim.fn.expand("~/.config/nvim/spell/en.utf-8.add"),
  },
  exact_length = 0,
  first_case_insensitive = false,
})

cmp.setup.filetype("markdown", {
  sources = cmp.config.sources({
    { name = "dictionary", keyword_length = 2 },
    { name = "buffer", keyword_length = 3 },
    { name = "spell" },
    { name = "path" },
    { name = "emoji" },
  }),
})
