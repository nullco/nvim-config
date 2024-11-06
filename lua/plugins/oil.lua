return {
  'stevearc/oil.nvim',
  config = function ()
    local oil = require('oil')
    oil.setup {}

    vim.keymap.set("n", "-", oil.open_float, { desc = "Open parent directory" })
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
