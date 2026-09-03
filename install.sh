#!/usr/bin/env bash
# Symlink these dotfiles into ~/.config on this machine.
# Safe to re-run: existing files are backed up, correct symlinks are left alone.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d-%H%M%S)"

mkdir -p "$CONFIG"

# link SRC -> DEST, backing up whatever is already at DEST.
link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok    $dest"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "backup $dest -> $dest.bak.$STAMP"
    mv "$dest" "$dest.bak.$STAMP"
  fi
  ln -s "$src" "$dest"
  echo "link  $dest -> $src"
}

# Whole-directory configs.
link "$REPO/nvim"      "$CONFIG/nvim"
link "$REPO/aerospace" "$CONFIG/aerospace"
link "$REPO/ghostty"   "$CONFIG/ghostty"

# gh: only the shared config.yml — hosts.yml/auth stays local to each machine.
link "$REPO/gh/config.yml" "$CONFIG/gh/config.yml"

# Home-directory dotfiles.
link "$REPO/home/.zshrc"     "$HOME/.zshrc"
link "$REPO/home/.tmux.conf" "$HOME/.tmux.conf"

echo
echo "Done. For nvim, create machine-specific settings:"
echo "  cp \"$REPO/nvim/lua/custom/local.lua.example\" \"$REPO/nvim/lua/custom/local.lua\""
echo "  # then edit paths/tokens, and run: gh auth login"
