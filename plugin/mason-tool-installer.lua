vim.pack.add({ "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" })

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettier",
		"eslint_d",
		"ruff",
	},
})
