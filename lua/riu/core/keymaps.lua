vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- General
map("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlights" })
map("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after paging down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after paging up" })

-- Visual mode: keep selection / don't clobber register
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv", { desc = "Dedent keeping selection" })
map("v", ">", ">gv", { desc = "Indent keeping selection" })
map("v", "p", '"_dp', { desc = "Paste without overwriting register" })
map("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
map({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete to blackhole register" })

-- Buffer (workspace) management
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "New empty buffer" })
map("n", "<leader>bc", "<cmd>bdelete!<CR>", { desc = "Close buffer" })
map("n", "<leader>bh", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "<leader>bl", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })

-- Tabs
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Splits
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- Explorer keymaps live in riu.plugins.nvim-tree (owns lazy-loading)