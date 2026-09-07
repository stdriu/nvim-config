-- WallSync-style live theme reload (adapted to matugen).
--
-- Watches the matugen-generated palette file and, whenever it changes on
-- disk (i.e. `matugen image <wallpaper>` ran), re-reads the palette and
-- reapplies every highlight group without restarting Neovim.
--
-- This mirrors what NvChad's WallSync does for base46, but for the native
-- riu.theme engine.

local highlight = require("riu.core.highlight")
local uv = vim.uv or vim.loop

local M = {}

local PALETTE_PATH = vim.fn.expand("~/.cache/matugen/nvim-palette.lua")
local DEBOUNCE_MS = 500

local watcher = nil
local debounce_timer = nil

local function reload()
  vim.schedule(function()
    local ok, err = pcall(highlight.reload)
    if ok then
      vim.notify("Theme: wallpaper palette reloaded", vim.log.levels.INFO)
    else
      vim.notify("Theme: failed to reload palette - " .. tostring(err), vim.log.levels.ERROR)
    end
  end)
end

-- Debounce rapid successive writes from matugen.
local function debounced_reload()
  if debounce_timer then debounce_timer:stop() end
  debounce_timer = uv.new_timer()
  debounce_timer:start(DEBOUNCE_MS, 0, reload)
end

local function start_watcher()
  if watcher or not uv.fs_stat(PALETTE_PATH) then return end

  local handle = uv.new_fs_poll()
  local ok = handle:start(PALETTE_PATH, DEBOUNCE_MS, function(err, prev, curr)
    if not err and prev and curr
      and (prev.mtime.sec ~= curr.mtime.sec or prev.mtime.nsec ~= curr.mtime.nsec)
    then
      debounced_reload()
    end
  end)

  if not ok then
    handle:close()
    vim.notify("Theme: palette watcher failed to start", vim.log.levels.WARN)
    return
  end
  watcher = handle
end

function M.start()
  pcall(start_watcher)
  return watcher
end

function M.stop()
  if watcher then
    watcher:stop()
    watcher:close()
    watcher = nil
  end
end

return M
