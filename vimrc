set nocompatible              " be iMproved, required
filetype off                  " required
syntax on
set encoding=UTF-8

let g:NERDTreeNodeDelimiter = "\u00a0"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" Plugins for fuzzy finding
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Smooth scrolling
Plugin 'psliwka/vim-smoothie'
" All of your Plugins must be added before the following line
Plugin 'godlygeek/tabular' " Tabularize
Plugin 'scrooloose/nerdtree'
Plugin 'pangloss/vim-javascript'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'Yggdroot/indentLine'
Plugin 'ddollar/nerdcommenter'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'valloric/youcompleteme'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set nu
set relativenumber
" use 8 spaces for tabs on C files
set tabstop=8

" use tabs, not spaces
set noexpandtab

" swp files moved to a different folder
set directory^=$HOME/.vim/tmp/

" Copy to system clipboard instead of copying to unammed register
set clipboard=unnamedplus

" Nerdtree
set splitright
set splitbelow
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif
" Reveal in finder the current selected file
nmap <C-S-\> :NERDTreeFind<CR>
nmap <C-\> :NERDTreeToggle<CR>

" Some indentation rules, commented because I'm not so sure about using them
" set listchars=eol:↓,tab:\ \ ┊,trail:●,extends:…,precedes:…,space:·

" Let ctrl + p looking into hidden files
let g:ctrlp_show_hidden=1

