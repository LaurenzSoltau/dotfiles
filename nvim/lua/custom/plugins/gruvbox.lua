return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require('gruvbox').setup {
      transparent_mode = true,
      overrides = {
        SignColumn = { bg = '#282828' },
      },
    }
    vim.cmd.colorscheme 'gruvbox'
  end,
}
