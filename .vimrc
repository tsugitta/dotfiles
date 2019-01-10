syntax on

set fenc=utf-8
set nobackup
set noswapfile
set autoread

" show information
set number
set showcmd
set laststatus=2
set showmatch
set list listchars=tab:\▸\-

" enhance completion 
set wildmode=list:longest

" search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" remove highlights with esc * 2
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" editing
set tabstop=2

" Mouse support
set mouse=a
set guioptions+=a
set ttymouse=xterm2

" can focus to wrapped lines
nnoremap j gj
nnoremap k gk
