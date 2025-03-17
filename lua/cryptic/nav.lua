
-- Walk up from current directory to the $HOME looking for tag files
vim.opt.tags = { './tags', 'tags', './.tags', '.tags;'.. vim.fn.expand('$HOME') }

-- Window commands
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>wL', '<C-w>L', { desc = 'Move window to the right side' })
vim.keymap.set('n', '<leader>wJ', '<C-w>J', { desc = 'Move window to the bottom' })
vim.keymap.set('n', '<leader>wK', '<C-w>K', { desc = 'Move window to the top' })
vim.keymap.set('n', '<leader>wH', '<C-w>H', { desc = 'Move window to the left side' })
vim.keymap.set('n', '<leader>wr', '<C-w>r', { desc = 'Rotate the windows' })
vim.keymap.set('n', '<leader>+', '<C-w>5+', { desc = 'Increase current window vertical size' })
vim.keymap.set('n', '<leader>-', '<C-w>5-', { desc = 'Decrease current window vertical size' })
vim.keymap.set('n', '<leader><', '<C-w>5<', { desc = 'Increase current window horizontal size' })
vim.keymap.set('n', '<leader>>', '<C-w>5>', { desc = 'Decrease current window horizontal size' })

-- Make page up and down work in insert mode
vim.keymap.set('i', '<C-f>', '<C-o><C-f>', { desc = 'Ctrl+f in insert mode' })
vim.keymap.set('i', '<C-b>', '<C-o><C-b>', { desc = 'Ctrl+b in insert mode' })

-- Command Line Movement
vim.keymap.set('c', '<C-a>', '<C-b>', { desc = 'Jump to beginning of the line' })

-- Buffer nav
vim.keymap.set('n', '<left>', ':bprev<cr>', { desc = 'Navigate to previous buffer' })
vim.keymap.set('n', '<right>', ':bnext<cr>', { desc = 'Navigate to next buffer' })
vim.keymap.set('n', '<up>', ':cprev<cr>', { desc = 'Navigate to previous quickfix result' })
vim.keymap.set('n', '<down>', ':cnext<cr>', { desc = 'Navigate to next quickfix result' })

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    commit = 'a0bbec21143c7bc5f8bb02e0005fa0b982edc026',
    dependencies = {
      {
        'nvim-lua/plenary.nvim',
        commit = '50012918b2fc8357b87cff2a7f7f0446e47da174'
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        commit = 'cf48d4dfce44e0b9a2e19a008d6ec6ea6f01a83b',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        'nvim-telescope/telescope-ui-select.nvim',
        commit = '6e51d7da30bd139a6950adf2a47fda6df9fa06d2'
      },
    },
    config = function()
      require('telescope').setup {
        defaults = {},
        pickers = {
          colorscheme = {
            enable_preview = true
          }
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<space>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<space>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<space>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<space>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<space>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<space>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<space>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<space>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<space>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<space><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<space>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<space>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Search Neovim config
      vim.keymap.set('n', '<space>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    commit = 'f197a15b0d1e8d555263af20add51450e5aaa1f0',
    build = ':TSUpdate',
    opts = {
      -- Autoinstall languages that are not installed
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      ignore_install = { 'org' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' }
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'folke/todo-comments.nvim',
    commit = 'ae0a2afb47cf7395dc400e5dc4e05274bf4fb9e0',
    event = 'VimEnter',
    dependencies = {
      {
        'nvim-lua/plenary.nvim',
        commit = '50012918b2fc8357b87cff2a7f7f0446e47da174'
      }
    },
    opts = {
      signs = false
    },
    config = function (opts)
      require('todo-comments').setup(opts)
      vim.keymap.set('n', '<space>st', ':TodoTelescope<CR>', { desc = '[S]earch [T]odos' })
    end
  },
}
