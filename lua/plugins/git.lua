-- Adds git related signs to the gutter, as well as utilities for managing changes
-- See `:help gitsigns` to understand what the configuration keys do
return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }

      vim.keymap.set('n', '<Leader>gp', ':Gitsigns preview_hunk<CR>')
      vim.keymap.set('n', '<Leader>gl', ':Gitsigns toggle_current_line_blame<CR>')
    end,
  },
  {
    'tpope/vim-fugitive',
  },
}
