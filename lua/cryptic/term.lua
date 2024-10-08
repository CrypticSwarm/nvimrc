return {
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
}
