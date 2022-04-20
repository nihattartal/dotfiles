source ~/.config/nvim/plugins.vim

let mapleader=","

inoremap jk <esc>
nnoremap ; :

nnoremap <leader><leader> <C-^>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <Right> <C-w>l
nnoremap <Left> <C-w>h
nnoremap <Up> 5k
nnoremap <Down> 5j
" yank root of current file's name into the clipboard
nnoremap <leader>p :!echo % \| pbcopy<cr><cr>
"-----------------------------------------------------------
" Indentation
"-----------------------------------------------------------
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
colorscheme molokai256

autocmd FileType gitcommit setlocal spell

set number
set colorcolumn=121
set hidden
set noswapfile
set autoindent
set autoread
au CursorHold * checktime

set tags^=./.git/tags;

" Set Relative number
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" Highlight the line on the insert mode
:autocmd InsertEnter,InsertLeave * set cul!

" Enable use of the mouse for all modes
set mouse=a

" Show vertical and horizontal line for the cursor
set cursorcolumn
set cursorline

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

source ~/.config/nvim/fuzzy-finding.vim
source ~/.config/nvim/smart-tab.vim
source ~/.config/nvim/test-support.vim
source ~/.config/nvim/trailing-whitespace.vim
source ~/.config/nvim/ale.vim

if filereadable($HOME . '/.config/nvim/local.vim')
    source $HOME/.config/nvim/local.vim
endif

"-----------------------------------------------------------
" VIMRC
"------------------------------------------------------------
map <leader>ve :edit $MYVIMRC<cr>
map <leader>vs :source $MYVIMRC<cr>

"------------------------------------------------------------
" NerdTree
"------------------------------------------------------------
set modifiable
map <C-n> :NERDTreeToggle<CR>
map ] :NERDTreeFind<CR>
let g:NERDTreeWinSize = 30
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.jshint$']

"------------------------------------------------------------
" Airline
"------------------------------------------------------------
let g:airline_theme="luna"
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"-----------------------------------------------------------
" Ack
"-----------------------------------------------------------
nnoremap <leader>a :Ack<space>
let g:ackprg = 'rg --ignore-files `*.rbi` --vimgrep'


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
