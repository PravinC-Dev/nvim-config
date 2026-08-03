vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		markdown = { "prettier" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback", -- use LSP formatter only if no conform formatter is set
	},
})

vim.keymap.set({ "n", "v" }, "<leader>gf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer/selection" })
