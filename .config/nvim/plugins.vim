" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin('~/.config/nvim/plugged')

" Plugins
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf'
Plug 'zackhsi/fzf-tags'
Plug 'junegunn/fzf.vim'
Plug 'Shopify/shadowenv.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mileszs/ack.vim'

Plug 'lepture/vim-jinja'
Plug 'ahw/vim-pbcopy'
Plug 'jparise/vim-graphql'

Plug 'christoomey/vim-tmux-navigator'
" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Colorschemes
Plug 'joedicastro/vim-molokai256'

" System copy
Plug 'christoomey/vim-system-copy'


call plug#end()
