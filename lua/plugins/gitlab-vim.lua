return {
  'git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git',
  -- Activate when a file is created/opened
  event = { 'BufReadPre', 'BufNewFile' },
  -- Activate when a supported filetype is open
  ft = { 'go', 'javascript', 'python', 'ruby' },
  enabled = false,
  cond = function()
    -- Only activate if token is present in environment variable.
    -- Remove this line to use the interactive workflow.
    return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
  end,
  config = function()
    require('gitlab').setup {
      statusline = {
        -- Hook into the built-in statusline to indicate the status
        -- of the GitLab Duo Code Suggestions integration
        enabled = true,
      },
      code_suggestions = {
        auto_filetypes = { 'ruby', 'javascript', 'python' },
      }
    }
    vim.keymap.set('n', '<C-g>', '<Plug>(GitLabToggleCodeSuggestions)')
  end
}
