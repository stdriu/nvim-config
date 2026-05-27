local function setup_autopairs()
  local autopairs = require("nvim-autopairs")

  autopairs.setup({
    check_ts = true,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
      java = false,
    },
  })

  local ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
  local cmp_ok, cmp = pcall(require, "cmp")

  if ok and cmp_ok then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = setup_autopairs,
}
