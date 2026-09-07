local M = {}

local PALETTE_PATH = vim.fn.expand("~/.cache/matugen/nvim-palette.lua")

local function load_matugen()
  local chunk, err = loadfile(PALETTE_PATH)
  if not chunk then
    vim.notify("Theme: failed to load matugen palette: " .. tostring(err), vim.log.levels.WARN)
    return nil
  end
  local ok, palette = pcall(chunk)
  if not ok or type(palette) ~= "table" then
    vim.notify("Theme: matugen palette is invalid", vim.log.levels.WARN)
    return nil
  end
  return palette
end

-- Normalize the flat matugen Material You palette into semantic roles.
-- This is the base46-style "theme definition": the ONLY place that knows
-- how raw generator output maps to semantic color names. Highlight groups
-- and integrations reference these names, so changing generators (matugen,
-- pywal) only touches this file.
local function build_semantic(p)
  if not p then return nil end
  return {
    -- UI background/surface roles
    bg = p.bg or p.surface,
    bg_dark = p.surface_low or p.surface,
    bg_alt = p.surface_variant or p.surface_container,
    bg_popup = p.surface_container or p.surface,
    bg_float = p.surface or p.bg,
    bg_hover = p.surface_high or p.surface_container,

    -- Foreground/neutral roles
    fg = p.fg or p.on_surface,
    fg_alt = p.on_surface_variant or p.fg,
    fg_dim = p.outline or p.on_surface_variant,
    grey = p.outline or p.on_surface_variant,
    line = p.outline_variant or p.outline,
    selection = p.primary_container,
    pmenu = p.surface_container,

    -- Semantic brand roles
    primary = p.primary,
    on_primary = p.on_primary,
    primary_container = p.primary_container,
    on_primary_container = p.on_primary_container,
    secondary = p.secondary,
    on_secondary_container = p.on_secondary_container,
    error = p.error,
    on_error = p.on_error,
    warning = p.yellow,
    info = p.primary,
    hint = p.magenta,
    ok = p.green,

    -- Syntax hues
    red = p.red,
    green = p.green,
    blue = p.blue,
    yellow = p.yellow,
    cyan = p.cyan,
    magenta = p.magenta,

    -- Mode / source passthrough
    mode = p.mode or "dark",
    raw = p,
  }
end

--- Returns the current semantic palette (cached). Falls back to nil if the
--- matugen cache is missing/invalid. Callers should handle a nil palette
--- gracefully (skip theming) rather than error.
function M.get()
  if M._cached then return M._cached end
  local p = build_semantic(load_matugen())
  if p then M._cached = p end
  return p
end

--- Force reload of the palette (used by the WallSync-style watcher when the
--- matugen cache file changes on disk).
function M.reload()
  M._cached = nil
  return M.get()
end

return M
