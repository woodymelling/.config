#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.config"

# 1) Install Xcode CLI Tools if missing (required by Homebrew)
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  until xcode-select -p &>/dev/null; do sleep 5; done
fi

# 2) Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # On Apple Silicon, add brew to PATH
  eval "$(/opt/homebrew/bin/brew shellenv)" || true
fi

# 3) Run brew bundle
echo "Running brew bundle from $DOTFILES/brew/Brewfile..."
brew bundle --file="$DOTFILES/brew/brewfile"

# 4) Symlink configs back into $HOME (and other expected places)
echo "Creating symlinks..."

# Zsh
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/.zshrc"  "$HOME/.zshrc"

# 5) Switch the login shell to zsh if necessary
if [[ "$SHELL" != "/bin/zsh" ]]; then
  chsh -s /bin/zsh
fi

echo "✅  All done. Restart your terminal."

