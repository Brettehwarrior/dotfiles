vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4      -- A TAB character looks like 4 spaces
vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4   -- Number of spaces inserted when indenting

-- Leader key is Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "


require("config.lazy")

--------------------------- MAPPINGS --------------------------- 
-- Insert mode pleasantries
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete previous word", })
vim.keymap.set("i", "<C-Z>", "<C-O>u", { desc = "Undo", })

-- Enter/Shift-Enter to add lines in normal mode
vim.keymap.set("n", "<CRT>", "mzo<Esc>`z", { desc = "Add new line below current line", })

-- System copy/paste
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to system clipboard", })
vim.keymap.set("n", "<leader>p", "\"+p", { desc = "Paste from system clipboard", })
