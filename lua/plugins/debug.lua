-- Configures everything related to debug

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        'debugpy',
      },
    }

    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/[C]ontinue' })
    vim.keymap.set('n', '<leader>dj', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>dl', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>dk', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set [B]reakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {}

    vim.keymap.set('n', '<Leader>dt', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-python').setup '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
    require('dap.ext.vscode').load_launchjs(nil, { debugpy = { 'python' } })
  end,
}
