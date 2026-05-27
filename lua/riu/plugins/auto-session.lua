local function setup_auto_session()
  local auto_session = require("auto-session")
  local keymap = vim.keymap.set

  auto_session.setup({
    auto_restore_enabled = false,
    auto_session_suppress_dirs = { "~/", "~/Dev", "~/Downloads", "~/Documents", "~/Desktop" },
  })

  keymap("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore last session for current directory" })
  keymap("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for current working directory" })
end

return {
  "rmagatti/auto-session",
  config = setup_auto_session,
}
