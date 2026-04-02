return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters.pyresolve = function()
        local function executable(name)
          return vim.fn.executable(name) == 1
        end
        if executable('ruff') then
          return lint.linters.ruff
        elseif executable('flake8') then
          return lint.linters.flake8
        else
          vim.notify('Neither ruff nor flake8 is installed, pyresolve will not work', vim.log.levels.WARN)
          return nil
        end
      end

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        python = { 'pyresolve' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({'TextChanged', 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
}
