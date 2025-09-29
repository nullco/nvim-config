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

-- Buffer management
vim.keymap.set('n', '<Leader>bo', [[:%bd | e# | bd#<CR> | ']], { desc = 'Close all buffers but current one' })
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
vim.keymap.set('n', '<Leader>wbd', [[:bp | bd#<CR>]], { desc = 'Windows: Close current window buffer without closing window' })
