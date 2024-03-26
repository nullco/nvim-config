-- Toggle terminals easily
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<C-\>]],
      shade_terminals = false,
      direction = 'float',
      on_create = function(term)
        if vim.env.VIRTUAL_ENV == nil then
          return
        end
        term:send('source ' .. vim.env.VIRTUAL_ENV .. '/bin/activate')
        term:send 'clear'
      end,
    }
  end,
}
