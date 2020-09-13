set guicursor=

set relativenumber
set number

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
set nohlsearch

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

map <Space> <Nop>
let g:mapleader = " "

call plug#begin()
  Plug 'ap/vim-css-color'
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  Plug 'honza/vim-snippets'
  Plug 'markonm/traces.vim' " :s command preview
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  if exists('g:started_by_firenvim')
    call plug#end()
    set background=light
    set colorcolumn&
    " hide statusline
    set noshowmode
    set noruler
    set laststatus=0
    set noundofile
    set noshowcmd
    finish
  end
  Plug 'airblade/vim-gitgutter'
  Plug 'altercation/vim-colors-solarized'
  Plug 'alvan/vim-closetag'
  Plug 'benmills/vimux'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'edkolev/tmuxline.vim'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  Plug 'itchyny/lightline.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'jrudess/vim-foldtext'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install } }
  Plug 'junegunn/fzf.vim'
  Plug 'justinmk/vim-sneak'
  Plug 'luochen1990/rainbow'
  Plug 'majutsushi/tagbar'
  Plug 'mattn/emmet-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense features
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-repeat'
  Plug 'vim-ruby/vim-ruby'
  Plug 'vim-test/vim-test'
call plug#end()

syntax enable
colorscheme solarized
set background=dark

let ruby_no_expensive = 1
let ruby_operators = 1
let ruby_pseudo_operators = 1

" Tagbar
let g:tagbar_autofocus=1
let g:tagbar_left = 1
let g:tagbar_width = 35
let g:tagbar_autopreview = 1
let g:tagbar_sort = 0
let g:tagbar_previewwin_pos = 'aboveleft'

nnoremap <F8> :TagbarToggle<CR>

hi Folded cterm=none

" vim-fugitive diffs are hard to read with solarized
" without this fix
hi diffRemoved ctermfg=1

" vimux
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
" Enter the tmux pane in copy mode
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vz :VimuxZoomRunner<CR>
let g:VimuxUseNearest = 0
let g:VimuxRunnerType = 'window'

" vim-test
let test#strategy = 'neovim'

nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>ts :TestSuite<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>

function TerminalBindings()
  if &buftype == 'terminal'
    tnoremap <C-n> <C-\><C-N>
    nnoremap <silent> q :bd!<CR>
  else
    tnoremap <C-n> <C-n>
    nnoremap <silent> q q
  endif
endfunction

augroup terminalgroup
  autocmd!
  autocmd TermEnter,TermLeave,TermClose,BufEnter * call TerminalBindings()
augroup END

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
" let g:AutoPairsFlyMode = 1
" let g:AutoPairsShortcutBackInsert = '<C-b>'

let g:AutoPairsShortcutToggle = ''

let g:closetag_filenames = '*.html,*.html.erb'

" erb with vim-rails
" https://stackoverflow.com/questions/4275209/how-do-i-insert-erb-tags-with-vim


inoremap <C-CR> <CR><Up><Tab>

" Emmet
let g:user_emmet_mode = 'i'

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
