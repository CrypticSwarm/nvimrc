vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- UI Related
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
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
vim.opt.smartindent = false -- 'smartindent' breaks right-shifting of # lines.
vim.opt.inccommand = 'split' -- Preview substitutions live


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

-- Conceal config
vim.opt.concealcursor = 'c'
vim.opt.conceallevel = 2

-- Menu config
vim.opt.wildmenu = true           -- Use menu when autocompleting
vim.opt.wildmode = "longest,full" -- Use bash style for first tab, then wildmenu for double
vim.opt.cursorline = false        -- Don't highlight the current screen line...
vim.opt.cursorcolumn = false      -- ...or screen column...
vim.opt.virtualedit = "block"     -- Virtual edit when in visual block mode
vim.opt.diffopt = vim.opt.diffopt + "vertical" -- Ensure diffs open in vertical splits

-- Util commands
vim.keymap.set('i', 'kj', '<ESC>', { desc = 'Alias for existing insert mode' })
vim.keymap.set('v', '.', ':normal .<cr>', { desc = 'Repeat in visual mode', silent = true })

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

-- Built in file browser
vim.g.netrw_banner = 0    -- Don't display the netrw banner
vim.g.netrw_winsize = -35
vim.g.netrw_liststyle = 3 -- Use tree-mode as default view
vim.g.netrw_preview = 1   -- preview window shown in a vertically split
vim.keymap.set('n', '<leader>f', ':Lexplore<CR>', { desc = "Open [F]ile tree", silent = true })

-- Lazy package manager config
vim.opt.rtp:prepend(vim.fn.stdpath 'config' .. '/deps/lazy')

vim.g.have_nerd_font = true

-- Resize window autocmd
local resize_group = vim.api.nvim_create_augroup('resizeWindow', { clear = true })
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = resize_group,
  command = 'exe "normal \\<C-W>="',
})

require('lazy').setup({
  require 'cryptic/theme',
  require 'cryptic/edit',
  require 'cryptic/nav',
  require 'cryptic/term',
  require 'cryptic/git',
  require 'cryptic/org',
  require 'cryptic/lsp',
  require 'cryptic/completion'
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
