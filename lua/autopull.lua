local book_dir = vim.fn.expand("~/Irregular")

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.schedule(function()  -- yields to the UI, lets it paint first
            local cwd = vim.fn.getcwd()

            if not cwd:match("^" .. vim.pesc(book_dir)) then
                return
            end

            local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
            if not git_root or git_root == "" then
                return
            end

            vim.system({ "git", "-C", git_root, "status", "--porcelain" }, { text = true }, function(status_obj)
                if status_obj.stdout ~= "" then
                    vim.schedule(function()
                        vim.notify("Git pull skipped: working tree not clean", vim.log.levels.WARN)
                    end)
                    return
                end

                vim.system(
                    { "git", "-C", git_root, "pull", "--rebase", "--autostash" },
                    { text = true },
                    function(pull_obj)
                        vim.schedule(function()
                            if pull_obj.code == 0 then
                                vim.notify("Git pull successful:\n" .. pull_obj.stdout, vim.log.levels.INFO)
                            else
                                vim.notify("Git pull failed:\n" .. pull_obj.stderr, vim.log.levels.ERROR)
                            end
                        end)
                    end
                )
            end)
        end)
    end,
})
