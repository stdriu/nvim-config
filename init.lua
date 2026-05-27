require("riu.core")

if vim.g.nix_managed then
  require("riu.nix")
else
  require("riu.lazy")
end

-- An example subset of your init.lua

local function source_matugen()
  -- Update this with the location of your output file
  local matugen_path = os.getenv("HOME") .. "/.config/nvim/matugen.lua" -- dofile doesn't expand $HOME or ~

  local file, err = io.open(matugen_path, "r")
  -- If the matugen file does not exist (yet or at all), we must initialize a color scheme ourselves
  if err ~= nil then
    -- Some placeholder theme, this will be overwritten once matugen kicks in
    vim.cmd('colorscheme base16-catppuccin-mocha')

    -- Optionally print something to the user
    vim.print(
      "A matugen style file was not found, but that's okay! The colorscheme will dynamically change if matugen runs!")
  else
    dofile(matugen_path)
    io.close(file)
  end
end

-- Main entrypoint on matugen reloads
local function auxiliary_function()
  -- Load the matugen style file to get all the new colors
  local matugen_path = os.getenv("HOME") .. "/.config/nvim/generated.lua"
  source_matugen()

  -- Because reloading base16 overwrites lualine configuration, just source lualine here
  if vim.g.nix_managed then
    local success, lualine_spec = pcall(require, 'riu.plugins.lualine-nvim')
    if success and type(lualine_spec) == "table" and lualine_spec.config then
      -- Explicitly clear it from package cache so it re-reads if needed
      package.loaded['riu.plugins.lualine-nvim'] = nil
      -- Run the lualine setup logic safely
      lualine_spec.config()
    else
      -- Fallback if the module layout isn't loaded yet
      pcall(require, 'lualine')
    end
  else
    dofile(os.getenv("HOME") .. '/.config/nvim/lua/riu/plugins/lualine-nvim.lua') -- path of your lualine setup
  end
  -- Any other options you wish to set upon matugen reloads can also go here!
  vim.api.nvim_set_hl(0, "Comment", { italic = true })
end

-- Register an autocmd to listen for matugen updates
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  callback = auxiliary_function,
})

-- Additionally call this function once on startup to query for matugen's theme
-- or set a default
auxiliary_function()
