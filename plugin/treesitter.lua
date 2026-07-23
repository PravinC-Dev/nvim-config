vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter'
      and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

-- Install parsers explicitly (replaces ensure_installed)
local ts = require('nvim-treesitter')
local installed = require('nvim-treesitter.config').get_installed()
local wanted = {
  "bash", "lua", "c", "cpp", "python",
  "javascript", "html", "css", "markdown", "markdown_inline",
}
local to_install = vim.tbl_filter(function(p)
  return not vim.tbl_contains(installed, p)
end, wanted)
if #to_install > 0 then
  ts.install(to_install)
end

-- Highlighting and indentation are now enabled per-buffer via FileType
vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
