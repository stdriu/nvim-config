local function setup_lualine()
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = ' ', right = ' ' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { 'NvimTree', 'snacks_dashboard' },
        winbar = { 'NvimTree' },
      },
      ignore_focus = {},
      always_divide_middle = true,
      -- Single global statusline (NvChad style): one statusline for all
      -- windows, so it coexists cleanly with bufferline's tabline.
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    -- Winbar: filename on the left, LSP breadcrumbs on the right.
    winbar = {
      lualine_c = {
        { 'filename', path = 1, padding = { left = 1, right = 1 } },
      },
      lualine_x = {
        {
          function()
            local ok, navic = pcall(require, 'nvim-navic')
            if not ok then return '' end
            return navic.get_location()
          end,
          cond = function()
            local ok, navic = pcall(require, 'nvim-navic')
            return ok and navic.is_available()
          end,
          padding = { left = 1, right = 1 },
        },
      },
    },
    winbar_inactive = {
      lualine_c = {
        { 'filename', path = 1, padding = { left = 1, right = 1 } },
      },
    },
    extensions = {},
  }
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  config = setup_lualine,
}