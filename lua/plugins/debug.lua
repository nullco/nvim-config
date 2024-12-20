-- Configures everything related to debug

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python'
  },
  config = function()
    -- vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
    -- vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
    -- vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

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
        'debugpy',
      },
    }

    vim.keymap.set({'n', 'v'}, '<Leader>de', widgets.preview, { desc = 'Debug: Evalualte expression' })
    vim.keymap.set('n', '<Leader>dp', dap.repl.toggle, { desc = 'Debug: REPL' })
    vim.keymap.set('n', '<Leader>dd', dap.terminate, { desc = 'Debug: Disconnect' })
    vim.keymap.set('n', '<Leader>dr', dap.restart, { desc = 'Debug: Restart' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Conditional [B]reakpoint' })

    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F6>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'Debug: Step Out' })

    -- Setup DAP for python
    dap_python.setup '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
    dap_python.test_runner = 'pytest'
    vim.keymap.set('n', '<Leader>dtm', dap_python.test_method, { desc = 'Debug: Test Current [M]ethod' })
    vim.keymap.set('n', '<Leader>dtc', dap_python.test_class, { desc = 'Debug: Test Current [C]lass' })

  end,
}
