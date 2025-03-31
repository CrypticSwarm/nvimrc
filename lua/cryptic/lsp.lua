return {
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
      {
        'hrsh7th/cmp-nvim-lsp',
        commit = '39e2eda76828d88b773cc27a3f61d2ad782c922d'
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
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

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
        ts_ls = {
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          }
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
}
