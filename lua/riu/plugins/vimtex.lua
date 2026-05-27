local M = {}

local function setup_vimtex()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_general_viewer = "okular" -- fallback
    vim.g.vimtex_compiler_method = "latexrun"
end

if not vim.g.nix_managed then
    M.lazy_spec = {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method
        end
    }
end
