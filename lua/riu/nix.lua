local M = {}

local function safe_require(module_name)
  local ok, result = pcall(require, module_name)
  if not ok then
    vim.notify("Failed to load module: " .. module_name .. " - " .. result, vim.log.levels.ERROR)
    return nil
  end
  return result
end

local function get_plugin_name(spec)
  local repo = spec[1] or ""
  local name = repo:match("/([%w-_.]+)$") or repo
  return name:gsub("%.nvim$", ""):gsub("^nvim-", "")
end

local function load_plugin_config(plugin_spec)
  if type(plugin_spec) ~= "table" then return end

  if plugin_spec.keys then
    for _, key in ipairs(plugin_spec.keys) do
      local mode = key.mode or "n"
      local lhs = key[1]
      local rhs = key[2]
      local opts = {
        desc = key.desc,
        noremap = key.noremap ~= false,
        silent = key.silent ~= false,
      }
      if lhs and rhs then
        vim.keymap.set(mode, lhs, rhs, opts)
      end
    end
  end

  local plugin_name = get_plugin_name(plugin_spec)
  if type(plugin_spec.config) == "function" then
    local ok, err = pcall(plugin_spec.config, plugin_spec, plugin_spec.opts or {})
    if not ok then
      vim.notify("Error in plugin config (" .. plugin_name .. "): " .. err, vim.log.levels.ERROR)
    end
  elseif plugin_spec.config == true or (plugin_spec.opts and plugin_spec.config == nil) then
    local ok, module = pcall(require, plugin_name)
    if ok and type(module.setup) == "function" then
      module.setup(plugin_spec.opts or {})
    end
  end
end

M.load_config = function()
  local plugins_modules = {
    "riu.plugins.auto-session",
    "riu.plugins.autopairs",
    "riu.plugins.oil",
    "riu.plugins.todo-comments",
    "riu.plugins.telescope",
    "riu.plugins.cord-nvim",
    "riu.plugins.snacks",
    "riu.plugins.lsp",
    "riu.plugins.cmp",
    "riu.plugins.luasnip",
    "riu.plugins.treesitter",
    "riu.plugins.table-mode",
    "riu.plugins.vimtex",
    "riu.plugins.indent-blankline",
    "riu.plugins.which-key",
    "riu.plugins.lualine-nvim",
    "riu.plugins.bufferline",
    "riu.plugins.direnv",
  }
  for _, module_name in ipairs(plugins_modules) do
    local plugin_spec = safe_require(module_name)
    if plugin_spec then
      load_plugin_config(plugin_spec)
    end
  end
end

M.load_config()

return M
