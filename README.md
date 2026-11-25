# dotfiles

## Layout
Each top-level folder is a [GNU stow](https://www.gnu.org/software/stow/) package
whose contents mirror `$HOME`:

| Package    | Installs                              |
|------------|---------------------------------------|
| `zsh`      | `~/.zshrc`, `~/.zprofile`, `~/.zsh_aliases` |
| `tmux`     | `~/.tmux.conf`                        |
| `ohmyposh` | `~/.config/ohmyposh/zen.toml`         |
| `nvim`     | `~/.config/nvim` (NvChad v2.5 starter + customisations) |
| `alacritty`| `~/.config/alacritty/alacritty.toml` (starts tmux) |

```sh
brew install stow
cd ~/dotfiles && stow zsh tmux ohmyposh nvim alacritty
```

### Not in this repo (public!)
Work / machine-specific config goes in `~/.zshrc.local` (sourced last by `.zshrc`)
and `~/.zsh_functions/*.zsh`. Copy those by hand.

## Requirements
- zsh (zinit bootstraps itself on first start)
- oh-my-posh, fzf (`brew install oh-my-posh fzf`)
- tmux + tpm (`brew install tmux tpm`), then `prefix + I` to install plugins
- neovim, alacritty, JetBrainsMono Nerd Font
  (`brew install neovim ripgrep && brew install --cask alacritty font-jetbrains-mono-nerd-font`)
- nvim: plugins install on first launch; solargraph is expected at `~/.rbenv/versions/3.3.8/bin/solargraph`
- Optional, lazy/guarded: rbenv, nvm, sdkman, google-cloud-sdk in `/opt/google-cloud-sdk`

## Things I'm learning along the way

### How to comment multiple lines in vim
Visual block and then Shift + I, after entering the value, press esc

### Copying to the 'proper' buffer
Both VIM and TMUX copy to their own registers. Both configurations need to get something
added to them in order to copy to the operating system register instead of their own.
For VIM it's something like `*` is the register which is tied to the middle mouse
button while `+` is the one linked to ctrl + v.

### Resizing nerd tree window
To move the windows horizontally or vertically you need to do press `ctrl + w` and
then input the command for horizontal or vertical movement. This will move the screen
by 1 row or column. Each time you want to move by one column you have to do this
incantation, which becomes annoying... Mental note to see if it's worth looking into.
Horizontal move: `>` and `<`
Vertical move: '-` and `+`

## Something to figure out
- How to create a toggle command. e.g. Make it so when I press some combination of
keys, I can see the whitespace characters and when I press it again, it goes back
to how things were. (set listchars=eol:↓,tab:\ \ ┊,trail:●,extends:…,precedes:…,space:·)
