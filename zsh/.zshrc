# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Google Cloud SDK (PATH + completion)
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Prompt
if (( $+commands[oh-my-posh] )); then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi

# Add in zsh plugins (turbo mode — all load after prompt appears)
zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid atinit'zicompinit; zicdreplay'
zinit light Aloxaf/fzf-tab

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

# Add in snippets (turbo mode)
zinit wait lucid for \
  OMZP::git \
  OMZP::sudo \
  OMZP::aws \
  OMZP::kubectl \
  OMZP::kubectx \
  OMZP::command-not-found

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
if [[ -f ~/.zsh_aliases ]]; then
	source ~/.zsh_aliases
fi

# Functions (loaded in filename order: 01_*, 02_*, ...)
for f in ~/.zsh_functions/*.zsh(N); do
	source "$f"
done
unset f

# Shell integrations
(( $+commands[fzf] )) && eval "$(fzf --zsh)"
#eval "$(zoxide init --cmd cd zsh)"

# Don't close tmux with ctrl + d and do nothing
setopt IGNORE_EOF
bindkey -r '^D'

# SDKMAN (lazy-loaded)
export SDKMAN_DIR="$HOME/.sdkman"
sdk() {
  unset -f sdk
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk "$@"
}

# ~/.local/bin (claude, etc.)
export PATH="$HOME/.local/bin:$PATH"

# NVM (lazy-loaded to avoid ~2s startup cost)
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  nvm "$@"
}
node() { nvm; node "$@"; }
npm()  { nvm; npm "$@"; }
npx()  { nvm; npx "$@"; }

# Homebrew build flags
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"

# rbenv
(( $+commands[rbenv] )) && eval "$(rbenv init - --no-rehash zsh)"

# Push the current branch and copy the MR/PR URL to the clipboard
# GitLab: .../merge_requests/new... or .../merge_requests/<id> (existing MR)
# GitHub: .../pull/new/<branch> (only printed on first push; otherwise built from origin)
gpmr() {
  local branch="${1:-$(git branch --show-current)}" out url rc remote
  out=$(git push -u origin "$branch" 2>&1 | tee /dev/tty; exit ${pipestatus[1]})
  rc=$?
  url=$(print -r -- "$out" | grep -oE 'https://[^ ]+/(merge_requests/(new[^ ]*|[0-9]+)|pull/new/[^ ]+)' | head -1)
  if [[ -z $url && $rc -eq 0 ]]; then
    remote=$(git remote get-url origin)
    if [[ $remote == *github.com* ]]; then
      # git@github.com-work:org/repo.git | https://github.com/org/repo.git -> org/repo
      remote=${${remote#*github.com*[:/]}%.git}
      url="https://github.com/$remote/pull/new/$branch"
    fi
  fi
  if [[ -n $url ]]; then
    print -rn -- "$url" | pbcopy
    print -r -- "📋 copied: $url"
  fi
  return $rc
}

# Machine/work-specific config that must not live in this public repo
# (internal hosts, cluster aliases, etc.)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
