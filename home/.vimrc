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
set expandtab
set tabstop=2
set shiftwidth=2

" Mouse support
set mouse=a
set guioptions+=a
set ttymouse=xterm2

" can focus to wrapped lines
nnoremap j gj
nnoremap k gk

" emacs key bindings

imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <C-o>:call <SID>home()<CR>
imap <C-e> <End>
imap <C-d> <Del>
imap <C-h> <BS>
imap <C-k> <C-r>=<SID>kill()<CR>

function! s:home()
  let start_column = col('.')
  normal! ^
  if col('.') == start_column
  ¦ normal! 0
  endif
  return ''
endfunction

function! s:kill()
  let [text_before, text_after] = s:split_line()
  if len(text_after) == 0
  ¦ normal! J
  else
  ¦ call setline(line('.'), text_before)
  endif
  return ''
endfunction

function! s:split_line()
  let line_text = getline(line('.'))
  let text_after  = line_text[col('.')-1 :]
  let text_before = (col('.') > 1) ? line_text[: col('.')-2] : ''
  return [text_before, text_after]
endfunction
