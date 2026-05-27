local function setup_undotree()
  vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree Visualizer" })
end

return {
  "mbbill/undotree",
  config = setup_undotree,
}
