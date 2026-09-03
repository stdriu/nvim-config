local function setup_diffview()
  local actions = require("diffview.actions")

  require("diffview").setup({})
end

return {
  "sindrets/diffview.nvim",
  config = setup_diffview,
}
