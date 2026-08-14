vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })

require("tiny-inline-diagnostic").setup({
	preset = "modern",
	options = {
		show_source = { enabled = true },
		multilines = { enabled = true },
	},
})

-- Turn off Neovim's default virtual text so diagnostics don't render twice
vim.diagnostic.config({ virtual_text = false })
