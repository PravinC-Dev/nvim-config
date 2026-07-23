vim.pack.add({ 
    'https://github.com/mason-org/mason-lspconfig.nvim', 
    'https://github.com/mason-org/mason.nvim', 
})

require("mason").setup({})

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd", "pyright", "ts_ls", "html", "cssls" },
    automatic_enable = true,
})

-- vim.lsp.config("*", { capabilities = vim.lsp.protocol.make_client_capabilities() })
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim", "require" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = event.buf, desc = "Format" })
    end,
})
