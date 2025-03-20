vim.g.mapleader = " "
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("abb teh the")
vim.cmd("abb hte the")
vim.cmd("abb tostr to_string")
vim.cmd("abb tostr() to_string()")
vim.cmd([[highlight LualineFileNameBold gui=bold]])
vim.cmd([[highlight LualineDir guifg=#808080]])


vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", {})

vim.opt.number = true 
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")


