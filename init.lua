vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- UI Related
vim.opt.number = true
vim.opt.numberwidth = 4
-- vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.mouse = 'a'
-- vim.opt.updatetime = 250 -- Decrease update time
-- Decrease mapped sequence wait time
-- vim.opt.timeoutlen = 300 -- Displays which-key popup sooner
vim.opt.scrolloff = 3       -- Context lines at top and bottom of display.
vim.opt.sidescrolloff = 5   -- Context columns at left and right.
vim.opt.sidescroll = 1      -- Number of chars to scroll when scrolling sideways.

-- Set the hidden chars
vim.opt.list = false
vim.opt.listchars = { tab = '▸ ', eol = '¬', trail = '·', nbsp = '␣' }
vim.opt.iskeyword:append('-')
vim.opt.iskeyword:append('/')

-- Search Related
vim.opt.incsearch = true   -- Do incremental searching.
vim.opt.hlsearch = true    -- Highlight latest search pattern.
vim.opt.ignorecase = true  -- Ignore case for pattern matches (\C overrides).
vim.opt.smartcase = true   -- Override 'ignorecase' if pattern contains uppercase.

-- Tab Related
vim.opt.autoindent = true -- Copy indent from current line for new line.
vim.opt.smartindent = false -- 'smartindent' breaks right-shifting of # lines.
vim.opt.expandtab = true   -- Insert spaces for <Tab> press; use spaces to indent.
vim.opt.smarttab = true    -- Tab respects 'shiftwidth', 'tabstop', 'softtabstop'.
vim.opt.tabstop = 2        -- Set the visible width of tabs.
vim.opt.softtabstop = 2    -- Edit as if tabs are 2 characters wide.
vim.opt.shiftwidth = 2     -- Number of spaces to use for indent and unindent.
vim.opt.shiftround = true  -- Round indent to a multiple of 'shiftwidth'.
-- vim.opt.breakindent = true -- Enable break indent

-- Buffer related configs
vim.opt.hidden = true      -- allow hidden buffers
vim.opt.splitright = true  -- open vsp to the right
vim.opt.splitbelow = true  -- open sp to the below

vim.cmd.colorscheme 'desert'

-- Jump from insert into normal mode
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Alias for existing insert mode' })

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

-- Lazy package manager config
vim.opt.rtp:prepend(vim.fn.stdpath 'config' .. '/deps/lazy')

require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
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
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

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

      -- Search Neovim config
      vim.keymap.set('n', '<leader>sn', function()
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
  }
}, {
  ui = {
    -- Default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
