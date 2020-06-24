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
set nowritebackup
set undodir=~/.vim/.undo
set undofile
set incsearch

" Hybrid line number mode
set relativenumber
set number

set timeoutlen=1000
set ttimeoutlen=0

" activate before copy-pasting with F2
set pastetoggle=<F2>

set nocompatible
filetype on
filetype indent on
filetype plugin on

" Change pane separator style
hi VertSplit cterm=none ctermbg=0 ctermfg=0
set colorcolumn=81

set mouse=a

" :PlugInstall after sourcing to install
call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'altercation/vim-colors-solarized'
  Plug 'ap/vim-css-color'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'edkolev/tmuxline.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install } }
  Plug 'luochen1990/rainbow'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense features
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'vim-ruby/vim-ruby'
  Plug 'markonm/traces.vim' " :s command preview
  Plug 'junegunn/fzf.vim'
  Plug 'honza/vim-snippets'
call plug#end()

" https://github.com/altercation/vim-colors-solarized
" SOLARIZED 16/8 TERMCOL  
" --------- ---- -------  
" base03     8/4 brblack  
" base02     0/4 black    
" base01    10/7 brgreen  
" base00    11/7 bryellow 
" base0     12/6 brblue   
" base1     14/4 brcyan   
" base2      7/7 white    
" base3     15/7 brwhite  
" yellow     3/3 yellow   
" orange     9/3 brred    
" red        1/1 red      
" magenta    5/5 magenta  
" violet    13/5 brmagenta
" blue       4/4 blue     
" cyan       6/6 cyan     
" green      2/2 green    
syntax enable
colorscheme solarized
set background=dark

" fzf settings
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
imap <c-x><c-q> <plug>(fzf-complete-file)

" Sets linenumber to white 
set cursorline
hi CursorLineNr cterm=none ctermfg=15 ctermbg=0

" Recommended by vim-gitgutter
set updatetime=100
" Change stylings
set signcolumn=yes
hi SignColumn ctermbg=0
hi GitGutterAdd ctermbg=2 ctermfg=0
hi GitGutterChange ctermbg=3 ctermfg=0
hi GitGutterDelete ctermbg=1 ctermfg=0
hi GitGutterChangeDelete ctermbg=9 ctermfg=0

" rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
\  'ctermfgs': [9,3,4],
\  'operators': '_,\|:_', 
\ }
hi MatchParen cterm=bold ctermfg=8 ctermbg=3

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size=2
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=8

" CoC settings
source ~/.dotfiles/vim/coc.vim

" Lightlight settings
set laststatus=2

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'readonly', 'filename', 'fugitive', 'modified' ] ],
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'fugitive': 'LightlineFugitive',
  \   'cocstatus': 'coc#status'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" disables reduntant mode display
set noshowmode

