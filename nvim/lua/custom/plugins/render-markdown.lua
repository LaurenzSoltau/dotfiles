-- Pretty in-editor Markdown rendering: styled headings, bullets, code blocks,
-- tables, checkboxes and callouts, all while you keep editing the raw file.
-- See :help render-markdown
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- provides the markdown parser
    'echasnovski/mini.nvim', -- mini.icons for file/language glyphs
  },
  ft = { 'markdown', 'markdown_inline' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- Render while editing too, not only in normal mode.
    render_modes = { 'n', 'c', 't' },
    -- We have a Nerd Font, so use the nice icon glyphs.
    heading = {
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    },
    checkbox = {
      unchecked = { icon = '󰄱 ' },
      checked = { icon = '󰱒 ' },
    },
    -- LaTeX math ($..$ / $$..$$) rendered as a Unicode approximation via
    -- pylatexenc's latex2text. Set vim.g.latex2text_cmd in lua/custom/local.lua
    -- to a full path (e.g. a venv binary); otherwise fall back to PATH.
    latex = {
      enabled = true,
      converter = vim.g.latex2text_cmd or 'latex2text',
    },
  },
  keys = {
    { '<leader>tm', '<cmd>RenderMarkdown toggle<cr>', desc = '[T]oggle [m]arkdown render', ft = 'markdown' },
  },
}
