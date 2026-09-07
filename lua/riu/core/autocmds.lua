-- General editor autocmds, grouped in a single exposed augroup so plugins
-- can add to it. Keep the ones that are genuinely useful and generalized;
-- language/service-specific triggers live in their plugin configs.

local api = vim.api
local M = {}

M.augroup = api.nvim_create_augroup("RiuCore", { clear = false })

-- Reload a file's edits when it changes on disk and the buffer is unmodified.
api.nvim_create_autocmd("FileChangedShellPost", {
  group = M.augroup,
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk, buffer reloaded", vim.log.levels.INFO)
  end,
})

-- Keep the quickfix window auto-closed when not needed.
api.nvim_create_autocmd("FileType", {
  group = M.augroup,
  pattern = { "qf" },
  callback = function()
    vim.opt_local.wrap = false
    vim.opt_local.buflisted = false
  end,
})

-- Trim trailing whitespace on save for most filetypes.
local function trim_trailing_whitespace()
  local save = vim.fn.winsaveview()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.fn.winrestview(save)
end

api.nvim_create_autocmd("BufWritePre", {
  group = M.augroup,
  pattern = "*",
  callback = trim_trailing_whitespace,
})

return M