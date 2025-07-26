vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Performance optimizations for large codebases
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300
vim.opt.redrawtime = 1500
vim.opt.synmaxcol = 240
vim.opt.lazyredraw = true
vim.opt.ttyfast = true

-- Better search and navigation
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- Memory optimizations
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- UI improvements
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8