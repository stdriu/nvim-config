require("riu.core.options")
require("riu.core.keymaps")
require("riu.tabs")
require("riu.core.autocmds")
require("riu.core.highlight")

local augroup = require("riu.core.autocmds").augroup
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  once = true,
  callback = function()
    vim.schedule(function()
      require("riu.core.wallsync").start()
    end)
  end,
})
