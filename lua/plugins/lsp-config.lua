return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        PATH = "prepend",
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "vtsls", "pyright", "lua_ls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.vtsls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "typescript.tsx", "javascript.jsx" },
        cmd = { "/usr/local/bin/vtsls", "--stdio" },
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        cmd = { "/home/pravin/.nvm/versions/node/v20.12.2/bin/vscode-html-language-server", "--stdio" },
      })

      lspconfig.cssls.setup({
        capabilities = capabilities,
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" }
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,

      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        cmd = { "/opt/lua-language-server/bin/lua-language-server", "--stdio" }
      })

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        cmd = { "/home/Blegh/.cargo/bin/rust-analyzer" }
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end
  }
}
