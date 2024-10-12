return {
  {
    'hrsh7th/nvim-cmp',
    commit = 'ae644feb7b67bf1ce4260c231d1d4300b19c6f30',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        commit = '03c8e67eb7293c404845b3982db895d59c0d1538',
        build = 'make install_jsregexp',
      },
      {
        'saadparwaiz1/cmp_luasnip',
        commit = '05a9ab28b53f71d1aece421ef32fee2cb857a843'
      },
      {
        'hrsh7th/cmp-nvim-lsp',
        commit = '39e2eda76828d88b773cc27a3f61d2ad782c922d'
      },
      {
        'hrsh7th/cmp-path',
        commit = '91ff86cd9c29299a64f968ebb45846c485725f23'
      },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
          autocomplete = false
        },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },
}
