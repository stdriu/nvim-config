vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>pr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
vim.keymap.set("n", "<leader>ths", "<cmd>Telescope themes<CR>",
  { noremap = true, silent = true, desc = "Theme Switcher" })

vim.keymap.set("n", "<leader>pWs", function()
  local builtin = require("telescope.builtin") -- Loaded ONLY when pressed
  local word = vim.fn.expand("<cWORD>")
  builtin.grep_string({ search = word })
end, { desc = "Find Connected Words under cursor" })


return {
  "nvim-telescope/telescope.nvim",

  cmd = "Telescope",

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "andrew-george/telescope-themes",
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
        extensions = {
          themes = {
            enable_previewer = true,
            enable_live_preview = true,
            persist = {
              enabled = true,
              path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
            },
          },
        },
      },
    })

    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "themes")
  end,
}
