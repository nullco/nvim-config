return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      pickers = {
        find_files = {
          -- Show files inside hidden directories (e.g. .config/...), but
          -- always exclude .git. `fd --hidden` already skips the cwd's .git,
          -- but not submodule .git pointer files, so the explicit --exclude
          -- keeps things deterministic.
          hidden = true,
          find_command = { 'fd', '--type', 'f', '--color', 'never', '--hidden', '--exclude', '.git' },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    -- Custom buffer picker. builtin.buffers has no name/buftype filter, so we
    -- mirror it here and add an `opts.keep(bufnr)` predicate. Reuses the same
    -- MRU sort, grep previewer, generic sorter and <M-d> delete-buffer mapping.
    local pickers = require 'telescope.pickers'
    local finders = require 'telescope.finders'
    local make_entry = require 'telescope.make_entry'
    local conf = require('telescope.config').values
    local actions = require 'telescope.actions'

    local function is_fugitive(bufnr)
      return vim.api.nvim_buf_get_name(bufnr):match '^fugitive://' ~= nil
    end

    local function is_terminal(bufnr)
      return vim.bo[bufnr].buftype == 'terminal'
    end

    local function pick_buffers(opts)
      opts = opts or {}
      opts.prompt_title = opts.prompt_title or 'Buffers'
      local keep = opts.keep or function(_) return true end

      local bufnrs = vim.tbl_filter(function(bufnr)
        if vim.fn.buflisted(bufnr) ~= 1 then
          return false
        end
        if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(bufnr) then
          return false
        end
        if opts.ignore_current_buffer and bufnr == vim.api.nvim_get_current_buf() then
          return false
        end
        return keep(bufnr)
      end, vim.api.nvim_list_bufs())

      if not next(bufnrs) then
        vim.notify(opts.empty_msg or 'No buffers found', vim.log.levels.INFO)
        return
      end

      if opts.sort_mru then
        table.sort(bufnrs, function(a, b)
          return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
        end)
      end

      local buffers = {}
      for _, bufnr in ipairs(bufnrs) do
        local flag = bufnr == vim.fn.bufnr '' and '%' or (bufnr == vim.fn.bufnr '#' and '#' or ' ')
        table.insert(buffers, {
          bufnr = bufnr,
          flag = flag,
          info = vim.fn.getbufinfo(bufnr)[1],
        })
      end

      opts.bufnr_width = opts.bufnr_width or #tostring(math.max(unpack(bufnrs)))

      pickers
        .new(opts, {
          finder = finders.new_table {
            results = buffers,
            entry_maker = opts.entry_maker or make_entry.gen_from_buffer(opts),
          },
          previewer = conf.grep_previewer(opts),
          sorter = conf.generic_sorter(opts),
          default_selection_index = 1,
          attach_mappings = function(_, map)
            map({ 'i', 'n' }, '<M-d>', actions.delete_buffer)
            return true
          end,
        })
        :find()
    end

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    -- Source buffers only: drop fugitive:// buffers entirely and keep :term
    -- buffers in their own picker so src buffers stay clean.
    vim.keymap.set('n', '<leader><leader>', function()
      pick_buffers {
        sort_mru = true,
        prompt_title = 'Buffers (src)',
        empty_msg = 'No source buffers',
        keep = function(bufnr)
          return not is_fugitive(bufnr) and not is_terminal(bufnr)
        end,
      }
    end, { desc = '[ ] Find existing src buffers' })

    vim.keymap.set('n', '<leader>st', function()
      pick_buffers {
        sort_mru = true,
        prompt_title = 'Buffers (term)',
        empty_msg = 'No terminal buffers',
        keep = is_terminal,
      }
    end, { desc = '[S]earch [T]erm buffers' })
    vim.keymap.set('n', '<leader>sb', builtin.git_branches, { desc = '[S]earch [B]ranches' })
    vim.keymap.set('n', '<leader>sc', builtin.git_commits, { desc = '[S]earch [C]ommits' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
