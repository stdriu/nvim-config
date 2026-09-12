return {
  "AvengeMedia/base46",
  event = "VeryLazy",
  config = function(_, opts)
    local base46 = require("base46")
    base46.setup(opts)

    local ok, err = pcall(vim.cmd.colorscheme, "base46-matugen")
    if not ok then
      vim.notify("base46-matugen: " .. tostring(err), vim.log.levels.WARN)
      vim.cmd.colorscheme("base46-tokyonight")
    end

    vim.api.nvim_create_autocmd("Signal", {
      pattern = "USR1",
      callback = function()
        base46.theme_tables["base46-matugen"] = nil
        local ok2, err2 = pcall(vim.cmd.colorscheme, "base46-matugen")
        if ok2 then
          vim.notify("Matugen theme reloaded", vim.log.levels.INFO)
        else
          vim.notify("Reload failed: " .. tostring(err2), vim.log.levels.ERROR)
        end
      end,
    })
  end,
  opts = {
    integrations = {
      bufferline = true,
      cmp = true,
      defaults = true,
      devicons = true,
      git = true,
      lsp = true,
      mason = true,
      neotest = true,
      nvimtree = true,
      statusline = true,
      syntax = true,
      treesitter = true,
      telescope = true,
      whichkey = true,
      blink = true,
      ["snacks-dashboard"] = true,
      blankline = false,
      nvcheatsheet = false,
      tbline = false,
    },
  },
}
