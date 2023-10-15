# dotfiles

## TODO
Make a script that sets up everything in this repository. This means installing
everything that needs to be installed (check dependencies and install them too),
copies the files where they should be (or maybe create symlinks?) and leaves
everything ready to simply use. For now it's safe to assume it will be a new
installation and nothing exists, if something does, good luck.

## Requirements
To have a fully functioning set up you'll need the following programs installed:
- git: To install zsh, vundle and many more things
- cmake: For youcompleteme (vim plugin)
- vim-gtk: Or gtk3. This ensures vim is compiled with python or python3
- python: For everything pretty much
- curl: To install oh-my-zsh
- zsh: For obvious reasons
- tmux: Also pretty obvious

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
