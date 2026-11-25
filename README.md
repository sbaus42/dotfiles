# dotfiles

My macOS setup: zsh, tmux, oh-my-posh, neovim (NvChad) and alacritty, plus a
`Brewfile` with every Homebrew package I use.

## Setting up a new Mac

1. **Install Apple's command line tools** (this gives you `git`):
   ```sh
   xcode-select --install
   ```
2. **Clone this repo** to `~/.dotfiles` (HTTPS works before any SSH keys exist):
   ```sh
   git clone https://github.com/sbaus42/dotfiles.git ~/.dotfiles
   ```
3. **Run the installer**:
   ```sh
   ~/.dotfiles/install.sh
   ```
   It installs Homebrew if needed, installs everything in the `Brewfile`,
   links the config files into your home folder (see "How the linking works"),
   and installs the tmux plugins. Any file it would replace is moved to
   `~/.dotfiles-backup/<date>/` first, so nothing is lost. It is safe to run again.
4. **Copy the private files** from the old machine (they are not in this repo,
   because it's public):
   - `~/.zshrc.local`: work settings (Vault, cluster aliases), loaded at the end of `.zshrc`
   - `~/.zsh_functions/`: work shell functions
   - `~/.ssh/`: keys and config (then `git -C ~/.dotfiles remote set-url origin git@github.com:sbaus42/dotfiles.git`)
   - `~/.config/vault/`
5. **Install by hand** what Homebrew doesn't cover: Docker Desktop,
   Google Cloud SDK (into `/opt/google-cloud-sdk`), sdkman, and the Ruby
   version nvim's solargraph expects (`rbenv install 3.3.8 && gem install solargraph`).
6. **Open a new terminal.** zsh plugins download on the first start, and
   neovim plugins download the first time you run `nvim`.

### Switching an existing Mac to this repo
Same thing, but skip Homebrew if your packages are already installed:
```sh
~/.dotfiles/install.sh --no-brew
```
Your current config files are moved to `~/.dotfiles-backup/<date>/` and
replaced with links to this repo.

## How the linking works (GNU stow)
Each top-level folder is a *package*. Inside it, files are laid out exactly as
they should appear in your home folder:

| Package     | Ends up as                                          |
|-------------|-----------------------------------------------------|
| `zsh`       | `~/.zshrc`, `~/.zprofile`, `~/.zsh_aliases`         |
| `tmux`      | `~/.tmux.conf`                                      |
| `ohmyposh`  | `~/.config/ohmyposh/` (prompt theme)                |
| `nvim`      | `~/.config/nvim/` (NvChad v2.5 + my changes)        |
| `alacritty` | `~/.config/alacritty/alacritty.toml` (opens tmux)   |

`stow` doesn't copy anything. It creates **symlinks** (shortcuts): `~/.zshrc`
becomes a link pointing to `~/.dotfiles/zsh/.zshrc`. That means:

- **Editing** `~/.zshrc` (or `~/.dotfiles/zsh/.zshrc`, same file) changes the repo
  directly. Commit and push as usual to save it.
- **Getting updates** on another machine is just `git -C ~/.dotfiles pull`.
  The links already point at the repo, so there's nothing to re-run.
- **Adding a new file**: put it in the right package with the same path it
  should have under `~`, then run `cd ~/.dotfiles && stow <package>` (or re-run
  `install.sh`). Example: `~/.config/foo/bar.toml` goes in `foo/.config/foo/bar.toml`.
- **Removing the links** for a package: `cd ~/.dotfiles && stow -D <package>`.
- **See where a link points**: `ls -l ~/.zshrc`.

## Homebrew packages
`Brewfile` lists every package. After installing something new you want to keep,
add it there. `brew bundle --file ~/.dotfiles/Brewfile` installs anything missing,
and `brew bundle check --file ~/.dotfiles/Brewfile` shows what isn't installed yet.

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
