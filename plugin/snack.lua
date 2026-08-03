vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({
	-- Indent
	indent = {
		enabled = true,
		indent = { char = "▏" },
		scope = { enabled = false },
	},

	-- Bigfile
	bigfile = { enabled = true, notify = false, setFt = false },

	-- Quickfile
	quickfile = { enabled = true },
	image = {},
})
