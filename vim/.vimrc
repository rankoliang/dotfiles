set noerrorbells

" Expands tabs to spaces
set expandtab
set tabstop=2 softtabstop=2
set shiftwidth=2
set smartindent

set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/.undo
set undofile
set incsearch

" Hybrid line number mode
set relativenumber
set number

set timeoutlen=1000
set ttimeoutlen=0

call plug#begin('~/.vim/plugged')
  Plug 'altercation/vim-colors-solarized'
  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'edkolev/tmuxline.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'ap/vim-css-color'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  " Plug 'scrooloose/nerdcommenter'
  Plug 'airblade/vim-gitgutter'
call plug#end()

syntax enable
colorscheme solarized

" for lightline plugin
set laststatus=2

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ }

" disables --INSERT--/--VISUAL-- under the *line plugins
set noshowmode

" let g:airline_theme='solarized'
" let g:airline_powerline_fonts=1

" let g:airline_solarized_bg='dark'
set background=dark

" Sets linenumber to solarized green
set cursorline
hi CursorLineNr cterm=none ctermfg=2

" Recommended by vim-gitgutter
set updatetime=100
hi clear SignColumn
hi GitGutterAdd ctermbg=2 ctermfg=0
hi GitGutterChange ctermbg=3 ctermfg=0
hi GitGutterDelete ctermbg=1 ctermfg=0
hi GitGutterChangeDelete ctermbg=9 ctermfg=0
