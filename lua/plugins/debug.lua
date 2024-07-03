-- Configures everything related to debug

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python'
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local dap_python = require 'dap-python'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        'debugpy',
      },
    }

    vim.keymap.set('n', '<Leader>dc', dap.repl.toggle, { desc = 'Debug: Toggle REPL [C]onsole' })
    vim.keymap.set('n', '<Leader>dx', dap.terminate, { desc = 'Debug: Disconnect' })
    vim.keymap.set('n', '<Leader>dr', dap.restart, { desc = 'Debug: Restart' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Conditional [B]reakpoint' })
    vim.keymap.set('n', '<leader>dd', dap.clear_breakpoints, { desc = 'Debug: Delete All Breakpoints' })

    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F6>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'Debug: Step Out' })

    -- Setup DAP UI
    dapui.setup()

    vim.keymap.set('n', '<Leader>dl', dapui.toggle, { desc = 'Debug: Show [l]ast session result' })
    vim.keymap.set('n', '<Leader>de', dapui.eval, { desc = 'Debug: [E]valuate expression' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Setup DAP for python
    dap_python.setup '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
    dap_python.test_runner = 'pytest'
    vim.keymap.set('n', '<Leader>dtm', dap_python.test_method, { desc = 'Debug: Test Current [M]ethod' })
    vim.keymap.set('n', '<Leader>dtc', dap_python.test_class, { desc = 'Debug: Test Current [C]lass' })
  end,
}
