local function setup_cord()
  require("cord").setup({
    display = {
      theme = 'catppuccin',
      flavor = 'accent',
    },
  })
end

return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  event = "VeryLazy",
  config = setup_cord,
}
