local function setup_indent_blankline()
  require("ibl").setup({
    indent = { char = "┊" },
    scope = { enabled = true },
  })
end

return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = setup_indent_blankline,
}
