vim.pack.add({
    { src = "https://github.com/nvim-telescope/telescope.nvim" },


    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },

})
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'telescope-fzf-native.nvim'
      and ev.data.kind == 'install' then
      vim.system({ 'make' }, {
        cwd = ev.data.spec.path  -- plugin's install directory
      })
    end
  end
})

vim.pack.add({ 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' })

local telescope = require("telescope")
            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown ({})
                    },
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    }
                },
            })
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })  -- Space f f
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })    -- Space f g
