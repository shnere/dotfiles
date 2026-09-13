#!/usr/bin/env bash
# Usage: ./install.sh [--work]
# Symlinks configs into place, installs Homebrew packages and Cursor extensions.
# Run ./.macos separately for system defaults.
set -e
D="$(cd "$(dirname "$0")" && pwd)"

link() { # link <path in repo> <target>
  if [ -e "$2" ] && [ ! -L "$2" ]; then mv "$2" "$2.bak"; fi
  mkdir -p "$(dirname "$2")"
  ln -sfn "$D/$1" "$2"
}

link fish              ~/.config/fish
link karabiner         ~/.config/karabiner
link ghostty           ~/.config/ghostty
link git/ignore        ~/.config/git/ignore
link .gitconfig        ~/.gitconfig
link .vimrc.after      ~/.vimrc.after
link cursor/settings.json    "$HOME/Library/Application Support/Cursor/User/settings.json"
link cursor/keybindings.json "$HOME/Library/Application Support/Cursor/User/keybindings.json"

command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file="$D/Brewfile"
[ "$1" = "--work" ] && brew bundle --file="$D/Brewfile.work"

FISH="$(command -v fish)"
grep -qx "$FISH" /etc/shells || echo "$FISH" | sudo tee -a /etc/shells
[ "$SHELL" = "$FISH" ] || chsh -s "$FISH"
fish -c 'type -q fisher; or curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; fisher update'

command -v cursor >/dev/null && xargs -n1 cursor --install-extension < "$D/cursor/extensions.txt"

echo "Done. Work-only shell config and secrets go in ~/.config/work.fish and ~/.gitconfig.local (outside the repo)."
