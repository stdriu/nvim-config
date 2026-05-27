local function setup_which_key()
  require("which-key").setup({})

  vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
  end, { desc = "Buffer Local Keymaps (which-key)" })
end

return {
  "folke/which-key.nvim",
  config = setup_which_key,
}
