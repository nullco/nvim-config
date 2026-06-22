-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Reload configuration
vim.keymap.set('n', '<leader>r', ':source $MYVIMRC<CR>', { desc = 'Reload configuration' })

-- Clear highlight on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })

-- Some terminal mode useful keybindings. e.g. For windows, etc
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])

vim.keymap.set('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = 'Copy current file path' })

-- Double <Esc> in Terminal mode returns to Normal mode.
-- A lone <Esc> is forwarded to the program running in the terminal, so apps
-- that use <Esc> (vim, less, fzf, ...) keep working. A second <Esc> within
-- `timeout` ms leaves Terminal mode via <C-\><C-n> instead.
do
  local timer
  local timeout = 200

  vim.keymap.set('t', '<Esc>', function()
    if timer and not timer:is_closing() then
      timer:close()
      timer = nil
      -- second <Esc> within the window: leave Terminal mode
      vim.api.nvim_feedkeys(vim.keycode('<C-\\><C-n>'), 'nt', false)
      return
    end
    -- first <Esc>: arm the timer and forward <Esc> to the terminal program
    timer = vim.uv.new_timer()
    timer:start(timeout, 0, function()
      if timer and not timer:is_closing() then
        timer:close()
      end
      timer = nil
    end)
    vim.api.nvim_feedkeys(vim.keycode('<Esc>'), 'nt', false)
  end, { desc = 'Terminal: double <Esc> to Normal mode' })
end

-- Buffer management
vim.keymap.set('n', '<Leader>bd', function()
  local cur = vim.api.nvim_get_current_buf()
  -- reuse an existing unnamed buffer if one exists (even if modified)
  local target
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if b ~= cur and vim.bo[b].buflisted and vim.api.nvim_buf_get_name(b) == '' then
      target = b
      break
    end
  end
  if target then
    vim.cmd('buffer ' .. target)
  else
    vim.cmd('enew')
  end
  -- the buffer may have auto-wiped on switch-away (e.g. fugitive's bufhidden=wipe)
  if vim.api.nvim_buf_is_valid(cur) then
    pcall(vim.cmd, 'bd ' .. cur)
  end
end, { desc = 'Close buffer (keep window)' })
vim.keymap.set('n', '<Leader>bD', [[:%bd!<CR>]], { desc = 'Close all buffers' })
vim.keymap.set('n', '<Leader>bo', [[:%bd | e# | bd#<CR>]], { desc = 'Close all buffers but current one' })
vim.keymap.set('n', '<S-h>', ':tabp<CR>', { desc = 'Prev tab' })
vim.keymap.set('n', '<S-l>', ':tabn<CR>', { desc = 'Next tab' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Windows: Move focus one left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Windows: Move focus one right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Windows: Move focus one lower' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Windows: Move focus one up' })
vim.keymap.set('n', '<Leader>wl', '<C-w>v', { desc = 'Windows: split vertically' })
vim.keymap.set('n', '<Leader>wj', '<C-w>s', { desc = 'Windows: split horizontally' })
vim.keymap.set('n', '<Leader>wo', ':only<CR>', { desc = 'Windows: leave [o]nly current window open' })
