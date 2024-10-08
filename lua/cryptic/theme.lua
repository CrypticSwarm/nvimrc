return {
  {
    'folke/tokyonight.nvim',
    commit = '2cd12582c98a3552032824ffa67fd44b4d81184a',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    commit = 'b431d228b7bbcdaea818bdc3e25b8cdbe861f056',
    config = function ()
      require('lualine').setup({})
      vim.opt.showmode = false
    end
  },
}
