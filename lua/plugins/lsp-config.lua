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
        ensure_installed = { "tsserver", "pyright" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
        cmd = { "/home/pravin/.nvm/versions/node/v20.12.2/bin/typescript-language-server", "--stdio" },
        init_options = {
          preferences = {
            disableSuggestions = true,
          }
        }
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        cmd = {"/home/pravin/.nvm/versions/node/v20.12.2/bin/vscode-html-language-server", "--stdio"},
      })

      lspconfig.cssls.setup({
        capabilities = capabilities,
        cmd = {"/home/pravin/.nvm/versions/node/v20.12.2/bin/vscode-css-language-server", "--stdio"},
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
        
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end
  }
}
