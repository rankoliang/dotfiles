set nocompatible
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

filetype on
filetype indent on
filetype plugin on

set foldmethod=manual
set foldlevelstart=1
" Fixes jumping around with { / }
set foldopen-=block,hor
set foldcolumn=1
" set foldminlines=2

" Resizes split panes automatically
autocmd VimResized * wincmd =

set colorcolumn=81

" Mouse mode on
set mouse=a

set list
set listchars=tab:❯·,trail:·,eol:¬

" searches directories recursively
set path+=**

" displays matches with tab with a menu
set wildmenu

map <Space> <Nop>
let g:mapleader = " "
" :PlugInstall after sourcing to install
call plug#begin('~/.vim/plugged')
  " Plug 'jiangmiao/auto-pairs'
  " Plug 'ludovicchabant/vim-gutentags'
  " Plug 'nathanaelkane/vim-indent-guides'
  " Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'altercation/vim-colors-solarized'
  Plug 'ap/vim-css-color'
  Plug 'benmills/vimux'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'edkolev/tmuxline.vim'
  Plug 'honza/vim-snippets'
  Plug 'itchyny/lightline.vim'
  Plug 'jrudess/vim-foldtext'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install } }
  Plug 'junegunn/fzf.vim'
  Plug 'lervag/vimtex'
  Plug 'luochen1990/rainbow'
  Plug 'majutsushi/tagbar'
  Plug 'markonm/traces.vim' " :s command preview
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense features
  Plug 'ryanoasis/vim-devicons'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'vim-ruby/vim-ruby'
  Plug 'vim-test/vim-test'
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
" vimruby
let ruby_no_expensive = 1
let ruby_operators = 1
let ruby_pseudo_operators = 1
" let ruby_fold = 1
" let ruby_foldable_groups = 'def'

" Tagbar
let g:tagbar_autofocus=1
let g:tagbar_left = 1
let g:tagbar_width = 35
let g:tagbar_autopreview = 1
let g:tagbar_sort = 0
let g:tagbar_previewwin_pos = 'aboveleft'

nnoremap <F8> :TagbarToggle<CR>

" vimtex
let g:tex_flavor = 'xelatex'


hi Folded cterm=none

" vim-fugitive diffs are hard to read with solarized
" without this fix
hi diffRemoved ctermfg=1

" Nerdtree
" nnoremap <Leader>nt :NERDTreeToggle<CR>
" let g:webdevicons_enable = 1
" let g:webdevicons_enable_nerdtree = 1
" set encoding=UTF-8
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
" 	\	&& b:NERDTree.isTabTree()) | q | endif

" vimux
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
" Enter the tmux pane in copy mode
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vz :VimuxZoomRunner<CR>

" vim-test
let test#strategy = 'vimux'

nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>ts :TestSuite<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>

" " fzf settings
" " Mapping selecting mappings
nnoremap <leader><tab> <plug>(fzf-maps-n)
xnoremap <leader><tab> <plug>(fzf-maps-x)
onoremap <leader><tab> <plug>(fzf-maps-o)

nmap <C-P> <Nop>
nnoremap <C-P> :Files<CR>
inoremap <c-x><c-f> <Nop>
" " Insert mode completion
" inoremap <c-x><c-k> <plug>(fzf-complete-word)
inoremap <c-x><c-f> <Plug>(fzf-complete-path)
" inoremap <c-x><c-l> <plug>(fzf-complete-line)
" inoremap <c-x><c-q> <plug>(fzf-complete-file)

" fzf ripgrep
nmap \ <Nop>
nnoremap \ :RG<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

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

" Autopairs
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<C-b>'

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size=2
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=8

" CoC settings
source ~/.dotfiles/vim/coc.vim
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

