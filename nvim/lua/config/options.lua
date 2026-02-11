vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes:2"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", },
  callback = function ()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})
