return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        globalstatus = true,
        disabled_filetypes = {
          "dap-repl"
        }
      },
      sections = {
        lualine_c = {}
      },
      inactive_winbar = {
        lualine_c = {{"filename", filestatus = true, path = 1}}
      },
      winbar = {
        lualine_c = {{"filename", filestatus = true, path = 1}}
      }
    }
  end,
}
