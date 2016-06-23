"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------
set nocompatible               " Be iMproved

if has('vim_starting') " Set neobundle path at initial launch
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle')) " Initialize
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'vim-scripts/vim-auto-save'
NeoBundle 'tpope/vim-endwise' " Insert end for Ruby
NeoBundle 'tomtom/tcomment_vim' " Comment out with `ctrl + _`
NeoBundle 'tpope/vim-surround' " Lets `cs({` or so
NeoBundle 'vim-scripts/AnsiEsc.vim' " Colorize ANSI color for log file
NeoBundle 'kana/vim-submode' " For command customizing
NeoBundle 'mattn/emmet-vim'
NeoBundle 'rking/ag.vim' " Search with The Silver Searcher
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'scrooloose/syntastic'

NeoBundleLazy 'leafgarland/typescript-vim', {
\ 'autoload' : {
\   'filetypes' : ['typescript'] }
\}
NeoBundleLazy 'jason0x43/vim-js-indent', {
\ 'autoload' : {
\   'filetypes' : ['javascript', 'typescript', 'html'],
\}}
NeoBundle 'Quramy/tsuquyomi'

call neobundle#end()
NeoBundleCheck

"-------------------------------------------------------------------------------
" Plugin settings
"-------------------------------------------------------------------------------
let g:user_emmet_leader_key='<C-R>' " Emmet works with `C-R,`

let g:auto_save = 1 " Enable by default
let g:auto_save_in_insert_mode = 0

let g:js_indent_typescript = 1

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.

"-------------------------------------------------------------------------------
" Completion
"-------------------------------------------------------------------------------

" Parenthesis
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

function! DeleteParenthesesAdjoin() " http://qiita.com/m_mysht/items/56e5d5a17d07a64d8b65
    let pos = col(".") - 1
    let str = getline(".")
    let parentLList = ["(", "[", "{", "\'", "\""]
    let parentRList = [")", "]", "}", "\'", "\""]
    let cnt = 0

    let output = ""

    if pos == strlen(str)
        return "\b"
    endif
    for c in parentLList
        if str[pos-1] == c && str[pos] == parentRList[cnt]
            call cursor(line("."), pos + 2)
            let output = "\b"
            break
        endif
        let cnt += 1
    endfor
    return output."\b"
endfunction
inoremap <silent> <BS> <C-R>=DeleteParenthesesAdjoin()<CR>
inoremap <silent> <C-h> <C-R>=DeleteParenthesesAdjoin()<CR>

" tab settings
"-------------------------------------------------------------------------------
" Key binding
"-------------------------------------------------------------------------------
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" Split view commands (ref: http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca)
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" We love also Emacs <3
imap <C-k> <ESC>ld$a
imap <C-y> <ESC>pi
imap <C-d> <ESC>lxi
imap <C-p>  <ESC>"*pa

imap <C-a>  <Home>
imap <C-e>  <End>
imap <C-b>  <Left>
imap <C-f>  <Right>
imap <C-n>  <Down>
imap <C-p>  <UP>

imap <C-Space> <C-x><C-o>

"-------------------------------------------------------------------------------
" Appearance
"-------------------------------------------------------------------------------
set background=dark

" ターミナルタイプによるカラー設定
if &term =~ "xterm-256color" || "screen-256color"
  " 256色
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

set showmatch         " Highlight match parenthesis
set number            " Line number
set list              " Show the char which cannot be read
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex      " 印字不可能文字を16進数で表示
set hlsearch
set lazyredraw

"-------------------------------------------------------------------------------
" Etc
"-------------------------------------------------------------------------------
set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しをしない
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                     " ビープをならさない
set browsedir=buffer             " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd
set showmode
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効
set notitle

set tabstop=2
set autoindent
set smartindent
set expandtab
set shiftwidth=2

" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"ヤンクした文字は、システムのクリップボードに入れる
set clipboard=unnamed,autoselect

" Ev/Rvでvimrcの編集と反映
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

set helpfile=$VIMRUNTIME/doc/help.txt

set laststatus=2
set showtabline=2

filetype plugin indent on
syntax enable
