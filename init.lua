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

require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    commit = '2cd12582c98a3552032824ffa67fd44b4d81184a',
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
  },
  {
    'tpope/vim-surround',
    commit = 'aeb933272e72617f7c4d35e1f003be16836b948d'
  },
  {
    'tpope/vim-repeat',
    commit = '65846025c15494983dafe5e3b46c8f88ab2e9635'
  },
  {
    'tommcdo/vim-exchange',
    commit = 'd6c1e9790bcb8df27c483a37167459bbebe0112e'
  },
  {
    'esamattis/slimux', -- Temporary for now until figuring out a better way in nvim
    commit = '7056d0e12d29411dbae9591cab0c5bb798a8ff6c',
    config = function ()
      vim.keymap.set('n', '<leader>r', ':SlimuxREPLSendLine<CR>', { desc = '[R]un line', silent = true })
      vim.keymap.set('n', '<leader>e', 'vip:SlimuxREPLSendSelection<CR>', { desc = 'Run block', silent = true })
      vim.keymap.set('v', '<leader>r', ':SlimuxREPLSendSelection<CR>', { desc = '[R]un selection', silent = true })
      vim.keymap.set('n', '<leader>aa', ':SlimuxShellLast<CR>', { desc = 'Select shell', silent = true })
      vim.keymap.set('n', '<leader>ai', ':SlimuxShellPrompt<CR>', { desc = 'Shell prompt', silent = true })
    end
  },
  require 'cryptic/git',
  require 'cryptic/org',
  {
    -- Neovim Lua LSP configuration
    'folke/lazydev.nvim',
    commit = '491452cf1ca6f029e90ad0d0368848fac717c6d2',
    ft = 'lua',
    dependencies = {
      {
        'Bilal2453/luvit-meta',
        commit = 'ce76f6f6cdc9201523a5875a4471dcfe0186eb60',
        lazy = true
      }
    },
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } }
      }
    }
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    commit = '056f569f71e4b726323b799b9cfacc53653bceb3',
    dependencies = {
      {
        'williamboman/mason.nvim',
        commit = 'c43eeb5614a09dc17c03a7fb49de2e05de203924',
        config = true
      },
      {
        'williamboman/mason-lspconfig.nvim',
        commit = '25c11854aa25558ee6c03432edfa0df0217324be'
      },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        commit = 'c5e07b8ff54187716334d585db34282e46fa2932'
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('init-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find LSP symbols
          -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- LSP refactor
          -- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          -- map('<leader>ca', vim.lsp.buf.code_action, 'Execute [C]ode [A]ction')
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --
      --  Language servers keys:
      --  - cmd (table): Override the default command used to start the server.
      --  - filetypes (table): Override the default list of associated filetypes for the server.
      --  - capabilities (table): Override fields in capabilities. Used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      local servers = {
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        pyright = {},
        lua_ls = { -- https://luals.github.io/wiki/settings/
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        stylua = {}
      }

      --  To check the current status of installed tools and/or manually install other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()
      require('mason-tool-installer').setup { ensure_installed = vim.tbl_keys(servers) }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- Override only values explicitly passed by the server configuration.
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    commit = 'b431d228b7bbcdaea818bdc3e25b8cdbe861f056',
    config = function ()
      require('lualine').setup()
      vim.opt.showmode = false
    end
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
    }
  },
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
