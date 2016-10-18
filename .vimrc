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
NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'vim-scripts/vim-auto-save'
NeoBundle 'tpope/vim-endwise' " Insert end for Ruby
NeoBundle 'tomtom/tcomment_vim' " Comment out with `ctrl + _`
NeoBundle 'tpope/vim-surround' " Lets `cs({` or so
NeoBundle 'vim-scripts/AnsiEsc.vim' " Colorize ANSI color for log file
NeoBundle 'kana/vim-submode' " For command customizing
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'yaymukund/vim-rabl'
NeoBundle 'rking/ag.vim' " Search with The Silver Searcher
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'claco/jasmine.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'gorodinskiy/vim-coloresque'
NeoBundleLazy 'leafgarland/typescript-vim', {'autoload': {'filetypes' : ['typescript']}}
NeoBundleLazy 'jason0x43/vim-js-indent', {'autoload': {'filetypes' : ['javascript', 'typescript', 'html']}}
NeoBundleLazy 'Quramy/tsuquyomi', {'autoload': {'filetypes' : ['typescript']}}

call neobundle#end()
NeoBundleCheck

"-------------------------------------------------------------------------------
" Plugin settings
"-------------------------------------------------------------------------------

let g:user_emmet_leader_key='<C-R>' " Emmet works with `C-R,`

let g:auto_save = 1 " Enable by default
let g:auto_save_in_insert_mode = 0

let g:ctrlp_custom_ignore = 'node_modules'
let g:ctrlp_root_markers = ['.ctrlp']

let g:js_indent_typescript = 1

let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_disable_default_mappings = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
let g:syntastic_disabled_filetypes=['html']
let g:syntastic_javascript_checkers = ['eslint'] " You shouldn't use 'tsc' checker.

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Plugin key-mappings.
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1

hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
au FileType coffee,ruby,javascript,python IndentGuidesEnable
nmap <silent><Leader>ig <Plug>IndentGuidesToggle
"-------------------------------------------------------------------------------
" Syntax
"-------------------------------------------------------------------------------

au BufNewFile,BufRead *.json.jbuilder set ft=ruby
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee

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

"-------------------------------------------------------------------------------
" Key binding
"-------------------------------------------------------------------------------

nnoremap <silent><C-g> :Ag
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <silent><D-u> :AutoSaveToggle<CR>
nnoremap <silent><D-r> :TsuReferences<CR>
nnoremap <silent><D-F> :TsuSearch
nnoremap <silent><D-d> :TsuDefinition<CR>

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
nnoremap <ESC><ESC> :nohlsearch<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" We love also Emacs <3
imap <C-k>  <ESC>ld$a
imap <C-d>  <Del>
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
set lazyredraw

"-------------------------------------------------------------------------------
" Search
"-------------------------------------------------------------------------------

set ignorecase  " 大文字/小文字の区別なく検索する
set smartcase   " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan    " 検索時に最後まで行ったら最初に戻る
set ignorecase  " 大文字/小文字の区別なく検索する
set smartcase   " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan    " 検索時に最後まで行ったら最初に戻る
set incsearch   " インクリメンタルサーチを行う
set hlsearch    " 検索結果をハイライト
nmap n nzz

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

autocmd BufWritePre * :%s/\s\+$//ge " trim spaces of the end of line

autocmd BufWritePre * call s:remove_line_in_last_line()
function! s:remove_line_in_last_line()
  if getline('$') == ""
     $delete _
  endif
endfunction

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
filetype indent on
syntax enable
