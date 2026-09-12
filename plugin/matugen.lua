-- Stub: prevent matugen.nvim from registering its own SIGUSR1 handler.
-- base46 handles all theme reload via its own Signal USR1 autocmd.
if package.loaded["matugen"] then
  return
end

package.loaded["matugen"] = {
  setup = function() end,
  load = function() end,
  load_theme = function() end,
  reload_templates = function() end,
}
