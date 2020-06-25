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
set pastetoggle=<F3>

set nocompatible
filetype on
filetype indent on
filetype plugin on

" Change pane separator style
hi VertSplit cterm=none ctermbg=0 ctermfg=0
set colorcolumn=81

set mouse=a

map <Space> <Nop>
let g:mapleader = " "
" :PlugInstall after sourcing to install
call plug#begin('~/.vim/plugged')
  " Plug 'junegunn/fzf', { 'do': { -> fzf#install } }
  " Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'altercation/vim-colors-solarized'
  Plug 'ap/vim-css-color'
  Plug 'benmills/vimux'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'edkolev/tmuxline.vim'
  Plug 'honza/vim-snippets'
  Plug 'itchyny/lightline.vim'
  Plug 'luochen1990/rainbow'
  Plug 'markonm/traces.vim' " :s command preview
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense features
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'vim-ruby/vim-ruby'
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

" vimux
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
" Enter the tmux pane in copy mode
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vz :VimuxZoomRunner<CR>

" " fzf settings
" " Mapping selecting mappings
" nnoremap <leader><tab> <plug>(fzf-maps-n)
" xnoremap <leader><tab> <plug>(fzf-maps-x)
" onoremap <leader><tab> <plug>(fzf-maps-o)

" " Insert mode completion
" inoremap <c-x><c-k> <plug>(fzf-complete-word)
" inoremap <c-x><c-f> <plug>(fzf-complete-path)
" inoremap <c-x><c-l> <plug>(fzf-complete-line)
" inoremap <c-x><c-q> <plug>(fzf-complete-file)

" Sets linenumber bar
set cursorline
hi CursorLineNr cterm=none ctermfg=15 ctermbg=8
hi LineNr ctermbg=8

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
\  'operators': '_,_', 
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
" https://www.reddit.com/r/vim/comments/dat6zc/cocnvim_autocompletion_not_working_for_cspace_in/
inoremap <silent><expr> <C-_> coc#refresh()
" :CocConfig to change settings

" Lightlight settings
set laststatus=2

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste', ],
  \             [ 
  \               'coc_error', 'coc_warning', 
  \               'coc_hint', 'coc_info',
  \               'readonly', 'fugitive', 
  \               'filename', 'modified',
  \             ] ]
  \ },
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'fugitive': 'LightlineFugitive',
  \ },
  \ 'component_expand': {
  \   'coc_error'        : 'LightlineCocErrors',
  \   'coc_warning'      : 'LightlineCocWarnings',
  \   'coc_info'         : 'LightlineCocInfos',
  \   'coc_hint'         : 'LightlineCocHints',
  \   'coc_fix'          : 'LightlineCocFixes',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

let g:lightline.component_type = {
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
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

" https://github.com/neoclide/coc.nvim/issues/401

function! s:lightline_coc_diagnostic(kind, sign) abort
	let info = get(b:, 'coc_diagnostic_info', 0)
	if empty(info) || get(info, a:kind, 0) == 0
		return ''
	endif
	return printf('%s%d', a:sign, info[a:kind])
endfunction

function! LightlineCocErrors() abort
	return s:lightline_coc_diagnostic('error', 'E')
endfunction

function! LightlineCocWarnings() abort
	return s:lightline_coc_diagnostic('warning', 'W')
endfunction

function! LightlineCocInfos() abort
	return s:lightline_coc_diagnostic('information', 'I')
endfunction

function! LightlineCocHints() abort
	return s:lightline_coc_diagnostic('hints', 'H')
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" disables reduntant mode display
set noshowmode

