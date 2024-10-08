return {
  {
    'tpope/vim-fugitive',
    commit = '96c1009fcf8ce60161cc938d149dd5a66d570756',
    event = 'VimEnter',
    config = function ()
      vim.keymap.set('n', '<leader>gs', ':Git<cr>', { desc = '[G]it [S]tatus', silent = true })
      vim.keymap.set('n', '<leader>gd', ':Gdiff<cr>', { desc = '[G]it [D]iff', silent = true })
      vim.keymap.set('n', '<leader>gc', ':Git commit<cr>', { desc = '[G]it [C]ommit', silent = true })
      vim.keymap.set('n', '<leader>gw', ':Gwrite<cr>', { desc = '[G]it [W]rite', silent = true })
      vim.keymap.set('n', '<leader>gr', ':Gread<cr>', { desc = '[G]it [R]ead', silent = true })
      vim.keymap.set('n', '<leader>gb', ':Git blame<cr>', { desc = '[G]it [B]lame', silent = true })
      vim.keymap.set('n', '<leader>gl', ':Gclog', { desc = '[G]it [L]og', silent = true })
    end
  },
  {
    'tpope/vim-rhubarb', -- GBrowse support
    commit = 'ee69335de176d9325267b0fd2597a22901d927b1'
  },
}
