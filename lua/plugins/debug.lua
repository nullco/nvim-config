-- Configures everything related to debug

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python'
  },
  config = function()
    vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text='󰯲', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text='󰰍', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

    local dap = require 'dap'
    local dap_python = require 'dap-python'
    local widgets = require('dap.ui.widgets')

    dap.defaults.fallback.terminal_win_cmd = 'tabnew'


    require('mason-nvim-dap').setup {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        'debugpy', 'java-debug-adapter'
      },
    }

    vim.keymap.set({'n', 'v'}, '<Leader>de', widgets.preview, { desc = 'Debug: [e]valuate expression' })
    vim.keymap.set('n', '<Leader>di', dap.repl.toggle, { desc = 'Debug: [i]nteractive shell' })
    vim.keymap.set('n', '<Leader>dst', dap.terminate, { desc = 'Debug: [t]erminate session' })
    vim.keymap.set('n', '<Leader>dsr', dap.restart, { desc = 'Debug: [r]estart session' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: toggle [b]reakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: set conditional [B]reakpoint' })
    vim.keymap.set('n', '<leader>dD', dap.clear_breakpoints, { desc = 'Debug: [D]elete all breakpoints' })
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: start/continue' })
    vim.keymap.set('n', '<F6>', dap.step_over, { desc = 'Debug: step over' })
    vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: step into' })
    vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'Debug: step out' })

    -- Setup DAP for python
    dap_python.setup '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
    dap_python.test_runner = 'pytest'
    vim.keymap.set('n', '<Leader>dtm', dap_python.test_method, { desc = 'Debug: Test Nearest [M]ethod' })
    vim.keymap.set('n', '<Leader>dtc', dap_python.test_class, { desc = 'Debug: Test nearest [C]lass' })
  end,
}
