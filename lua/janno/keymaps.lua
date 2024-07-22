local map = require("janno.utils").map

-- Disables the arrow keys to force the usage of hjkl
map("n", "<up>", "<nop>")
map("n", "<down>", "<nop>")
map("n", "<left>", "<nop>")
map("n", "<right>", "<nop>")

-- Move line(s) up or down
-- Explanation for the maps below
-- https://stackoverflow.com/questions/69264441/is-there-a-way-to-copy-a-selected-area-up-or-down-in-vim
map("n", "<A-k>", "<cmd>m-2<CR>")
map("n", "<A-j>", "<cmd>m+1<CR>")
map("v", "<A-k>", ":m '<-2<CR>gv")
map("v", "<A-j>", ":m '>+1<CR>gv")

-- Switch buffer
map("n", "<A-.>", "<cmd>bnext<CR>")
map("n", "<A-,>", "<cmd>bprevious<CR>")
map("n", "<A-c>", "<cmd>bdelete<CR>")
map("n", "<A-C>", "<cmd>bdelete!<CR>")

-- Clear highlight search after pressing ESC in normal mode
map("n", "<ESC>", "<cmd>nohlsearch<CR>")

-- Easier mode change with pressing ESC from inside terminal mode to normal mode
map("t", "<ESC>", "<C-\\><C-n>")
