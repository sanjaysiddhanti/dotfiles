set nocompatible              " be iMproved, required
filetype off                  " required

set mouse=a
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

set rtp+=~/.fzf
Plugin 'junegunn/fzf.vim'

Plugin 'scrooloose/nerdtree'

Plugin 'airblade/vim-gitgutter'

Plugin 'morhetz/gruvbox'

Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Put your non-Plugin stuff after this line

" Enable bracketed paste mode for automatic paste detection
if &term =~ "xterm" || &term =~ "screen" || &term =~ "tmux"
    let &t_BE = "\e[?2004h"
    let &t_BD = "\e[?2004l"
    exec "set t_PS=\e[200~"
    exec "set t_PE=\e[201~"
endif

" Fallback: Toggle paste mode with F2 if bracketed paste doesn't work
set pastetoggle=<F2>

map ; :Files<CR>

colorscheme gruvbox
set background=dark

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Make NERDTree open files with single click
let g:NERDTreeMouseMode = 3
let NERDTreeShowHidden = 1
