-- [[ Floating terminal ]]
-- Toggle a popup (floating window) terminal with <leader>tt.
-- The shell/job persists across toggles, so you can hide and reopen it
-- without losing your session.

local float_term = { buf = -1, win = -1 }

local function toggle_float_term()
  -- If the window is currently open, just hide it (keep the buffer/job alive).
  if vim.api.nvim_win_is_valid(float_term.win) then
    vim.api.nvim_win_hide(float_term.win)
    return
  end

  -- Compute a centered floating window (80% of the editor).
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
  }

  -- Reuse the existing terminal buffer if it's still valid, otherwise make one.
  if not vim.api.nvim_buf_is_valid(float_term.buf) then
    float_term.buf = vim.api.nvim_create_buf(false, true)
  end

  float_term.win = vim.api.nvim_open_win(float_term.buf, true, win_opts)

  -- Start a shell only if this buffer isn't already running a terminal job.
  if vim.bo[float_term.buf].buftype ~= 'terminal' then
    vim.fn.jobstart(vim.o.shell, { term = true })
    -- Buffer-local hide key. NOT space/<Esc> prefixed, so it never makes the
    -- terminal wait `timeoutlen` on every space or escape sequence you type.
    vim.keymap.set('t', '<C-t>', toggle_float_term, { buffer = float_term.buf, desc = 'Hide floating terminal' })
  end

  vim.cmd 'startinsert'
end

-- Open/toggle from the editor. Normal mode only: mapping this in terminal mode
-- would make every <Space> in the shell block on `timeoutlen`.
vim.keymap.set('n', '<leader>tt', toggle_float_term, { desc = '[T]oggle floating [t]erminal' })

-- vim: ts=2 sts=2 sw=2 et
