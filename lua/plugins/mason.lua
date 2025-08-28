return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()

    -- Ensure the servers and tools below are installed
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    require('mason').setup()

    require('mason-tool-installer').setup {
      ensure_installed = {
        'pyright',
        'ts_ls',
        'lua_ls',
        'stylua', -- Used to format Lua code
        'markdownlint', -- Used to lint markdown
        'flake8', -- Python linter
      }
    }
  end,
}
