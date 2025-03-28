return {
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
    'mbbill/undotree',
    commit = '78b5241191852ffa9bb5da5ff2ee033160798c3b',
    config = function ()
      vim.keymap.set('n', '<leader>u', ':UndotreeToggle<cr>', { desc = '[U]ndo tree toggle', silent = true })
    end
  }
}
