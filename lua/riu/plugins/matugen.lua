local function setup_matugen()
  require("matugen").setup({
    palette_path = "~/.cache/matugen/nvim-colors.json",
    load_theme = true,
  })
end

return {
  "Senal-D-A-Gunaratna/matugen.nvim",
  priority = 1000,
  config = setup_matugen,
}
