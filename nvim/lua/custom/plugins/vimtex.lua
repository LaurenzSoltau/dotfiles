return {
  'lervag/vimtex',
  lazy = false, -- direkt beim Start laden
  config = function()
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 0

    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_start_on_save = 0
    vim.g.vimtex_compiler_latexmk = {
      build_dir = 'build',
      continuous = 0, -- ⬅️ ganz wichtig: Watch-Modus aus!
      options = {
        '-quiet',
      },
    }
  end,
}
