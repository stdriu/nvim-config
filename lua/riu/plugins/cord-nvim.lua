local function setup_cord()
  require("cord").setup({})
end

return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  config = setup_cord,
}
