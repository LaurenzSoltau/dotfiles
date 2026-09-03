# dotfiles

Personal macOS config for a handful of tools, kept portable so a new machine is
one clone away.

Included:

| Tool | Path linked to | Notes |
|------|----------------|-------|
| **Neovim** | `~/.config/nvim` | kickstart-based. Plugin versions pinned in `lazy-lock.json`. |
| **AeroSpace** | `~/.config/aerospace` | Tiling WM. Uses monitor *patterns*, not hardware IDs. |
| **Ghostty** | `~/.config/ghostty` | Terminal. Needs the *JetBrains Mono* font installed. |
| **GitHub CLI** | `~/.config/gh/config.yml` | Only shared prefs/aliases; auth is per-machine. |
| **Zsh** | `~/.zshrc` | Oh My Zsh setup. Sources `~/.zshrc.local` (untracked) for per-machine/secret bits. |
| **tmux** | `~/.tmux.conf` | Prefix `C-a`, vim-style panes, gruvbox theme via tpm. |

## Install on a new Mac

```sh
git clone <this-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` symlinks each config into `~/.config` and backs up anything already
there (as `*.bak.<timestamp>`). It is safe to re-run.

### After install

1. **Neovim machine-specific settings** (paths, tokens — not in git):
   ```sh
   cp nvim/lua/custom/local.lua.example nvim/lua/custom/local.lua
   # edit vim.g.python_cmd, vim.g.latex2text_cmd, etc.
   ```
2. **GitHub CLI auth** (token is stored in the macOS Keychain, not in the repo):
   ```sh
   gh auth login
   ```
3. **Zsh machine-specific bits** (optional — secrets, work paths):
   ```sh
   touch ~/.zshrc.local   # add per-machine exports here; not tracked
   ```
4. **tmux plugins**: install tpm, then press `prefix + I` (C-a I) inside tmux:
   ```sh
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

## Dependencies to install separately

These configs assume the following are present on the machine:

- **Apps**: Neovim, AeroSpace, Ghostty, GitHub CLI (`gh`), tmux
- **Shell**: Oh My Zsh (`~/.oh-my-zsh`) + the `zsh-syntax-highlighting` plugin
- **Fonts**: JetBrains Mono, plus a Nerd Font (nvim uses Nerd Font icons)
- **CLI tools** (for full nvim functionality): `ripgrep`, `fd`, `git`,
  Xcode Command Line Tools (`xcode-select --install`, for building
  telescope-fzf-native)
- **Shell tools** (used by `.zshrc`): `zoxide`, `fzf`; optional `ghcup` (Haskell)
- **Optional (nvim LaTeX-in-Markdown rendering)**: a Python with
  `pip install pylatexenc`, then point `vim.g.latex2text_cmd` at its
  `latex2text` binary in `local.lua`.

Most can be installed via Homebrew, e.g.:

```sh
brew install neovim ripgrep fd gh tmux zoxide fzf
brew install --cask nikitabobko/tap/aerospace ghostty font-jetbrains-mono font-jetbrains-mono-nerd-font
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
