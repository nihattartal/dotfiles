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

"----------------------------------------------------------
" Enable coc and make sorbet as language server
" ---------------------------------------------------------

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
"" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
""
"" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>d :Ack "def <C-r><C-w>" -g "!_test.rb"
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>


" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
