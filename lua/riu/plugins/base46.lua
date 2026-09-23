return {
  "AvengeMedia/base46",
  event = "VeryLazy",
  config = function(_, opts)
    local base46 = require("base46")
    base46.setup(opts)

    local function set_theme(name)
      local ok, err = pcall(vim.cmd.colorscheme, "base46-" .. name)
      if ok then
        vim.notify("Theme: " .. name, vim.log.levels.INFO)
      else
        vim.notify("Could not load base46-" .. name .. ": " .. tostring(err), vim.log.levels.WARN)
      end
      return ok
    end

    -- Fixed themes; toggle between them with :CycleTheme.
    local themes = { "oxocarbon", "kanagawa" }

    vim.api.nvim_create_user_command("CycleTheme", function()
      local cur = vim.g.colors_name
      if not cur or not cur:match("^base46%-") then
        set_theme(themes[1])
        return
      end
      local current = cur:gsub("^base46%-", "")
      local next = themes[1]
      if current == themes[1] then next = themes[2] end
      set_theme(next)
    end, { desc = "Cycle between oxocarbon and kanagawa" })

    -- Default theme on startup.
    set_theme(opts.theme or themes[1])

    -- Apply base46 integration work (statusline/winbar/bufferline etc).
    require("base46").setup(opts)
  end,
  opts = {
    theme = "kanagawa",
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
