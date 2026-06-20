local function setup_luasnip()
  require("luasnip.loaders.from_vscode").lazy_load()
end

return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = { "InsertEnter" },
  config = setup_luasnip,
}
