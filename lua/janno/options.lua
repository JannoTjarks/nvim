-- General VIM Settings
vim.opt.backup = true
vim.opt.backupdir = os.getenv("HOME") .. "/.vim/backup"
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.termguicolors = true

-- Accessablity
vim.opt.mouse = ""
vim.opt.showmode = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 5
vim.opt.ruler = true
vim.opt.number = true
vim.opt.autoread = true
vim.opt.fileformat = "unix"
vim.opt.clipboard:prepend("unnamedplus")

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tabs & Spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = "tab:»·,trail:·"
vim.opt.colorcolumn = "81"

-- Disable search info and mode because its shown in the lualine
vim.opt.showmode = false
vim.opt.shortmess:append("S")

-- Disable netrw because nvim-tree is used
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
