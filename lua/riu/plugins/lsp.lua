-- lua/riu/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_lsp.default_capabilities()

    -- 1. Configure standard language servers
    local standard_servers = {
      "lua_ls",       -- Lua
      "clangd",       -- C, C++
      "pyright",      -- Python
      "texlab",       -- LaTeX
      "ts_ls",        -- JavaScript, TypeScript, JSX, TSX
      "html",         -- HTML
      "cssls",        -- CSS
      "qmlls",        -- QML
    }
    for _, server in ipairs(standard_servers) do
      vim.lsp.config(server, { capabilities = capabilities })
      vim.lsp.enable(server)
    end

    -- 2. Configure nil_ls specifically to use Alejandra
    vim.lsp.config("nil_ls", {
      capabilities = capabilities,
      settings = {
        ["nil"] = {
          formatting = {
            command = { "alejandra" }, -- 👈 Instructs nil to format using the binary
          },
        },
      },
    })
    vim.lsp.enable("nil_ls")

    -- LSP Keybindings & Auto-format on save
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
          vim.tbl_extend("force", opts, { desc = "Code Action" }))

        -- Your existing format-on-save autocmd will now run alejandra automatically!
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = ev.buf,
          callback = function()
            vim.lsp.buf.format({ async = true })
          end,
        })
      end,
    })
  end,
}
