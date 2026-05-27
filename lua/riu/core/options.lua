local opt = vim.opt

opt.guicursor = ""
opt.relativenumber = true
opt.number = true

opt.mouse = "a"
opt.cursorline = true
opt.cursorcolumn = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.wrap = false

opt.autoindent = true
opt.smartindent = true

opt.swapfile = true
opt.backup = false
opt.undofile = true

opt.incsearch = true
opt.inccommand = "split"
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.hlsearch = true
opt.backspace = { "start", "eol", "indent" }

opt.splitright = true
opt.splitbelow = true

opt.cursorline = false
opt.list = true
opt.clipboard:append("unnamedplus")

vim.g.editorconfig = true
