return {
  'catppuccin/nvim',
  lazy = true,
  priority = 1000,
  name = 'catppuccin',
  opts = {
    integrations = {
      alpha = true,
      cmp = true,
      gitsigns = true,
      mason = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
      dap = true,
      dap_ui = true,
      nvimtree = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}
