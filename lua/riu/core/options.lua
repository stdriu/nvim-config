local opt = vim.opt

opt.guicursor = ""
opt.number = true
opt.relativenumber = false

opt.mouse = "a"

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.wrap = false
opt.autoindent = true
opt.smartindent = true

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.incsearch = true
opt.inccommand = "split"
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

opt.termguicolors = true
opt.background = "dark"
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.backspace = { "start", "eol", "indent" }

opt.splitright = true
opt.splitbelow = true

opt.cursorline = true
opt.cursorcolumn = false
opt.list = true
opt.clipboard:append("unnamedplus")

opt.laststatus = 2
opt.showtabline = 2

vim.g.editorconfig = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1