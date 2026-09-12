local matugen_theme = vim.fn.expand("~/.cache/matugen/nvim-colors.json")
local f = io.open(matugen_theme, "r")
if not f then
  vim.notify("Run matugen first", vim.log.levels.WARN)
  return
end
local json = f:read("*a")
f:close()

local palette = vim.json.decode(json)

---@type Base46Table
local theme = {
  type = "dark",
  base_30 = {
    white = palette.on_surface,
    black = palette.surface,
    darker_black = palette.surface_low,
    black2 = palette.surface_container,
    one_bg = palette.surface_container,
    one_bg2 = palette.surface_high,
    one_bg3 = palette.surface_highest,
    grey = palette.outline,
    grey_fg = palette.on_surface_variant,
    grey_fg2 = palette.on_surface_variant,
    light_grey = palette.outline_variant,
    red = palette.error,
    baby_pink = palette.tertiary_container,
    pink = palette.tertiary,
    line = palette.outline_variant,
    green = palette.git_added,
    vibrant_green = palette.primary_container,
    nord_blue = palette.secondary,
    blue = palette.secondary,
    yellow = palette.tertiary,
    sun = palette.primary_container,
    purple = palette.tertiary,
    dark_purple = palette.tertiary_container,
    teal = palette.secondary_container,
    orange = palette.error,
    cyan = palette.secondary,
    statusline_bg = palette.surface_container,
    lightbg = palette.surface_high,
    pmenu_bg = palette.surface_container,
    folder_bg = palette.secondary,
  },
  base_16 = {
    base00 = palette.surface,
    base01 = palette.surface_container,
    base02 = palette.surface_high,
    base03 = palette.surface_highest,
    base04 = palette.outline,
    base05 = palette.on_surface,
    base06 = palette.on_surface_variant,
    base07 = palette.on_primary_container,
    base08 = palette.error,
    base09 = palette.tertiary,
    base0A = palette.primary,
    base0B = palette.secondary,
    base0C = palette.secondary,
    base0D = palette.secondary,
    base0E = palette.tertiary,
    base0F = palette.error,
  },
}

local theme_name = "base46-matugen"
require("base46").theme_tables[theme_name] = theme
require("base46").load(theme_name)
vim.g.colors_name = theme_name
