-- Markdown-only editing tweaks.
-- Loaded automatically for markdown buffers (see :help after-directory, ftplugin).

-- Soft-wrap at word boundaries instead of mid-word. `wrap` is already on;
-- `breakindent` (set globally in options.lua) keeps wrapped text indented.
vim.wo.linebreak = true

-- Move by *visual* line with j/k, so a wrapped paragraph doesn't feel like it
-- jumps a whole screenful. A count (e.g. 5j) still moves by real lines.
local opts = { buffer = true, expr = true, silent = true }
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", opts)
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", opts)
vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", opts)
vim.keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", opts)

-- vim: ts=2 sts=2 sw=2 et
