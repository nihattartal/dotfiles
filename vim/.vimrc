set nocompatible
set noswapfile
set dir=~/tmp
let mapleader=","
set nocompatible
set pastetoggle=<F11>

"-----------------------------------------------------------
" Indentation
set expandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType groovy setlocal shiftwidth=4 tabstop=4
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html.handlebars setlocal shiftwidth=2 tabstop=2
autocmd FileType exs setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType xsd setlocal shiftwidth=2 tabstop=2
autocmd FileType xslt setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType jinja setlocal shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal shiftwidth=2 tabstop=2
autocmd FileType rs setlocal shiftwidth=2 tabstop=2
" ------------------------------------------------
"
au FileType php setl noexpandtab
autocmd FileType php setlocal shiftwidth=4 tabstop=4


"-----------------------------------------------------------
" Syntax highlighting

au BufReadPost *.hbs set syntax=mustache

"-----------------------------------------------------------
" Strip spaces on write
autocmd BufWritePre *.js,*.rb,*.py :%s/\s\+$//e

" Enable syntax highlighting
syntax on

" Colorscheme
set background=dark
colorscheme monokai

" Allow for switching between buffers without saving
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

set hlsearch
nmap <silent> ,/ :nohlsearch<CR>

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

"------------------------------------------------------------
" Word wrap

:set wrap
:set linebreak
:set nolist  " list disables linebreak

"------------------------------------------------------------
" Special key mappings
nnoremap j gj
nnoremap k gk
nnoremap ; :
nnoremap ' ;
nnoremap ;gs :Gstatus<CR>
nnoremap ;gc :Gcommit<CR>
nnoremap ;gca :Gcommit --amend<CR>
nnoremap ;gw :Gwrite<CR>
nnoremap ;gr :Gread<CR>
nnoremap <Up> 5k
nnoremap <Down> 5j
nnoremap ,, <C-^>
"------------------------------------------------------------
" Split navigation
"------------------------------------------------------------

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"------------------------------------------------------------
" Plug bindings
"------------------------------------------------------------

nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>

"------------------------------------------------------------
" FZF bindings
"------------------------------------------------------------
nnoremap <leader>f :FZF<CR>
nnoremap <leader>a :Ack<space>
nnoremap <leader>sl :Lines<CR>
nnoremap <leader>sb :BLines<CR>
nnoremap <leader>b :Buffers<CR>

"------------------------------------------------------------
" PERSONAL
"------------------------------------------------------------
" yank root of current file's name into the clipboard
nnoremap <leader>p :!echo % \| pbcopy<cr><cr>
"------------------------------------------------------------
" Plug
"------------------------------------------------------------
call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mileszs/ack.vim'

Plug 'mustache/vim-mustache-handlebars', { 'for': 'html.handlebars' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'michaeljsmith/vim-indent-object'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'w0rp/ale'

Plug 'chase/vim-ansible-yaml'

Plug 'lepture/vim-jinja'

Plug 'rust-lang/rust.vim'

Plug 'ahw/vim-pbcopy'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'jparise/vim-graphql'
Plug 'leafgarland/typescript-vim'
Plug 'christoomey/vim-tmux-navigator'
" Initialize plugin system
call plug#end()

"------------------------------------------------------------
" NerdTree

set modifiable
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 30
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.jshint$']

"------------------------------------------------------------
" Airline

let g:airline_theme="luna"
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"------------------------------------------------------------
" Mustache

let g:mustache_operators = 1

"------------------------------------------------------------
" Ale
"------------------------------------------------------------
"
" Configure a.l.e. syntax checking
 let g:ale_linters = {
 \   'javascript': ['eslint'],
 \   'python': ['flake8'],
 \   'ruby': ['rubocop'],
 \   'graphql': ['gqlint'],
 \   'yaml': ['yaml-lint']
 \}
 " Only lint on save.
 let g:ale_lint_on_save = 1
 let g:ale_lint_on_text_changed = 0

 " Customize flags
 let g:ale_sign_error = '✖︎'
 let g:ale_sign_warning = '❢'

"------------------------------------------------------------
" FZF
"------------------------------------------------------------

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '40' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)

" Insert mode completion
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

"-----------------------------------------------------------s
" Ack
"-----------------------------------------------------------

let g:ackprg = 'ag --vimgrep'

"-----------------------------------------------------------s
" Bclose
"-----------------------------------------------------------

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
nnoremap ;bc :Bclose<CR>

" aj goes to next lint error
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" jk escapes
imap jk <Esc>

" Highlight the line on the insert mode
:autocmd InsertEnter,InsertLeave * set cul!

" Set Relative number
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

set clipboard+=unnamedplus
set colorcolumn=121

source ~/dotfiles/vim/trailing-whitespace.vim

" Autoreload the file if it's changed outside of vim
set autoread

if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction

set tags^=./.git/tags;

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'ruby': ['~/.gem/ruby/2.6.5/bin/solargraph', 'stdio'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Git branch files
function! QuickfixGitBranchFiles()
  let git_branch_files = systemlist('~/bin/git-list-branch-files')
  call setqflist(map(copy(git_branch_files), '{ "filename": v:val }'))
  copen
  cc
endfunction
nnoremap <leader>1 :call QuickfixGitBranchFiles()<CR>

"set clipboard=
