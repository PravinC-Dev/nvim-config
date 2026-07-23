vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
require('mini.basics').setup()
require('mini.surround').setup()
require("mini.pairs").setup()
require("mini.comment").setup({ ignore_blank_line = true, })
vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle Comment (Normal mode)" })    -- Space /
vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle Comment (Visual mode)" })

require('mini.files').setup({
  windows = {
    preview = true,       -- preview file contents on the right
    width_focus = 30,
    width_preview = 50,
  },
  options = {
    use_as_default_explorer = true,  -- replaces netrw too
  },
})

-- Toggle with <leader>e, opening at current file's directory
vim.keymap.set("n", "<leader>e", function()
  if not MiniFiles.close() then
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
  end
end, { desc = "Toggle File Explorer" })
