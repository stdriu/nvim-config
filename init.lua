require("riu.core")

if vim.g.nix_managed then
  require("riu.nix")
else
  require("riu.lazy")
end

require("direnv").setup({
  autoload_direnv = false,  
})

local function source_matugen()
  local matugen_path = os.getenv("HOME") .. "/.config/nvim/colors/matugen.lua"~

  local file, err = io.open(matugen_path, "r")
  if err ~= nil then
    vim.cmd('colorscheme base16-catppuccin-mocha')

    vim.print(
      "A matugen style file was not found, but that's okay! The colorscheme will dynamically change if matugen runs!")
  else
    dofile(matugen_path)
    io.close(file)
  end
end

local function auxiliary_function()
  source_matugen()

  if vim.g.nix_managed then
    local success, lualine_spec = pcall(require, 'riu.plugins.lualine-nvim')
    if success and type(lualine_spec) == "table" and lualine_spec.config then
      package.loaded['riu.plugins.lualine-nvim'] = nil
      lualine_spec.config()
    else
      pcall(require, 'lualine')
    end
  else
    dofile(os.getenv("HOME") .. '/.config/nvim/lua/riu/plugins/lualine-nvim.lua') 
  end
  vim.api.nvim_set_hl(0, "Comment", { italic = true })
end

vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = auxiliary_function,
})

auxiliary_function()

local transparent_groups = {
  "Normal", "NormalNC", "NormalFloat",
  "FloatBorder", "SignColumn", "LineNr",
  "CursorLine", "CursorLineNr", "StatusLine"
}

for _, group in ipairs(transparent_groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none" })
end
