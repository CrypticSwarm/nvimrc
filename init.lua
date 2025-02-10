vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

-- Toggles
vim.keymap.set('n', '<leader>ts', ':set spell!<CR>', { desc = '[T]oggle [S]pell' })
vim.keymap.set('n', '<leader>tl', ':set list!<CR>', { desc = '[T]oggle [L]ist special characters' })

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
