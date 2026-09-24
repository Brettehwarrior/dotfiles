
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set("i", "<C-BS>", "<C-w>", {
  desc = "Delete previous word",
})

vim.keymap.set("i", "<C-Z>", "<C-O>u", {
  desc = "Undo",
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "


require("config.lazy")
