return {
  {
    'dracula/vim',
    name = 'dracula',
    init = function()
      vim.g.dracula_colorterm = 0
      vim.cmd.colorscheme 'dracula'
    end,
  },
}
