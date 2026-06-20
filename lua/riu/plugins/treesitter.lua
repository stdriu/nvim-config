local function setup_treesitter()
  local ok, ts = pcall(require, "nvim-treesitter.configs")
  if ok then
    ts.setup({
      ensure_installed = {},
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end

  vim.treesitter.language.register("latex", "tex")

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "tex", "bib" },
    callback = function()
      vim.opt.conceallevel = 2
      vim.opt.concealcursor = "nc"
    end,
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = setup_treesitter,
}
