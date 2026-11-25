#!/usr/bin/env bash
# Set up this machine from the dotfiles repo. Safe to re-run.
#
#   ./install.sh            install Homebrew packages + link dotfiles
#   ./install.sh --no-brew  only link dotfiles (skip Homebrew)
#
# Existing files that would be replaced are moved to ~/.dotfiles-backup/<timestamp>/
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(zsh tmux ohmyposh nvim alacritty)
# Folders that should become one symlink as a whole (moved aside entirely if they exist)
WHOLE_DIRS=(.config/nvim)
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

SKIP_BREW=false
[[ "${1:-}" == "--no-brew" ]] && SKIP_BREW=true

say() { printf '\n\033[1;35m==> %s\033[0m\n' "$*"; }

backup() { # move $HOME/<rel> into the backup folder, keeping its path
  local rel="$1"
  mkdir -p "$BACKUP/$(dirname "$rel")"
  mv "$HOME/$rel" "$BACKUP/$rel"
  echo "  backed up ~/$rel"
}

# 1. Homebrew + packages ------------------------------------------------------
if ! $SKIP_BREW; then
  if ! xcode-select -p >/dev/null 2>&1; then
    say "Installing Xcode Command Line Tools — re-run this script when it finishes"
    xcode-select --install
    exit 1
  fi
  if ! command -v brew >/dev/null 2>&1 && [[ ! -x /opt/homebrew/bin/brew ]]; then
    say "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
  # Homebrew 7+ refuses to load third-party taps until they are trusted.
  # Only the taps listed in the Brewfile are trusted.
  say "Trusting the third-party taps listed in the Brewfile"
  for tap in $(awk -F'"' '/^tap /{print $2}' "$DOTFILES/Brewfile"); do
    brew tap "$tap"
    brew trust --tap "$tap"
  done
  say "Installing Homebrew packages (Brewfile)"
  brew bundle --file "$DOTFILES/Brewfile"
else
  [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi

command -v stow >/dev/null || { echo "stow is missing: brew install stow"; exit 1; }

# 2. Move conflicting files out of the way ------------------------------------
say "Checking for existing files that would be replaced"
for rel in "${WHOLE_DIRS[@]}"; do
  if [[ -e "$HOME/$rel" && ! -L "$HOME/$rel" ]]; then backup "$rel"; fi
done
for pkg in "${PACKAGES[@]}"; do
  while IFS= read -r -d '' file; do
    rel="${file#"$DOTFILES/$pkg/"}"
    target="$HOME/$rel"
    if [[ -e "$target" && ! -L "$target" ]]; then backup "$rel"; fi
  done < <(find "$DOTFILES/$pkg" -type f -print0)
done
[[ -d "$BACKUP" ]] && echo "  backups are in $BACKUP" || echo "  nothing to back up"

# 3. Link everything ------------------------------------------------------------
say "Linking dotfiles into $HOME with stow"
# ~/.config must be a real folder, otherwise stow could turn it into a link into this repo
mkdir -p "$HOME/.config"
stow --dir "$DOTFILES" --target "$HOME" --restow "${PACKAGES[@]}"

# 4. tmux plugins ---------------------------------------------------------------
say "Installing tmux plugins"
for tpm in /opt/homebrew/opt/tpm/share/tpm "$HOME/.tmux/plugins/tpm"; do
  if [[ -x "$tpm/bin/install_plugins" ]]; then
    "$tpm/bin/install_plugins" || echo "  tpm failed — open tmux and press prefix + I"
    break
  fi
done

# 5. Reminders ------------------------------------------------------------------
say "Done. Remaining manual steps:"
cat <<'EOF'
  - Copy private files from the old machine (not in this public repo):
      ~/.zshrc.local   ~/.zsh_functions/   ~/.ssh/   ~/.config/vault/
  - Install by hand: Docker Desktop, Google Cloud SDK (/opt/google-cloud-sdk), sdkman
  - Open a new terminal (zinit installs zsh plugins on first start)
  - Run nvim once (plugins install on first start)
EOF
