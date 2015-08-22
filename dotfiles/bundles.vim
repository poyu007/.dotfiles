"""""""""""""""""""""""""""""""""""""""""""""""""
" default
"""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
"==========================================
" Basic infomation Settings 文件编码,格式
"==========================================
" 设置新文件的编码为 UTF-8

"set wildmenu
"set wildmode=list:longest
"set wildmode=longest:full,full
set ttyfast       " Vim Scrolling Slowly
set autoindent    " 打开自动缩进
" 合并两行中文时，不在中间加空格：
set formatoptions+=B
set ambiwidth=single
set wrap
set whichwrap=b,s,<,>,[,]
set showbreak=↪
set backspace=eol,start,indent
set viminfo^=%
set magic "正则:  除了 $ . * ^ 之外其他元字符都要加反斜杠。http://blog.charlee.li/vim-regexp/  "
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set backspace=indent,eol,start    " allow backspacing over everything in insert
set laststatus=2   " Always show the statusline
set smartindent   " Smart indent
" never add copyindent, case error   " copy the previous indentation on autoindenting
set clipboard=unnamed
" tab相关变更
set tabstop=4     " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4  " 每一次缩进对应的空格数
set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab     " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
"set shiftround    " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'

set number "显示行号：

" Searching
set ignorecase " 有一个或以上大写字母时仍大小写敏感
set incsearch " 搜索时忽略大小写
set smartcase
set showmatch
set hlsearch  " 打开增量搜索模式,随着键入即时搜索


" How many tenths of a second to blink when matching brackets
set matchtime=2 " 括号配对情况,跳转并高亮一下匹配的括号





"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" 编码
set history=400   " keep 400 lines of command line history

syntax enable
" In many terminal emulators the mouse works just fine, thus enable it.

map Q gq



au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline
set cursorcolumn

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent        " always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""
filetype off


if isdirectory("/usr/local/vim/bundle")
    set rtp+=/usr/local/vim/bundle/vundle/
    call vundle#rc('/usr/local/vim/bundle')
else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

endif


""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""

" required!
Bundle 'gmarik/vundle'


"--------------
"" Color Schemes
"--------------
"Bundle 'tomasr/molokai'
Bundle 'altercation/vim-colors-solarized'
"Bundle 'rickharris/vim-blackboard'
"Bundle 'rickharris/vim-monokai'
"Bundle 'tpope/vim-vividchalk'
"Bundle 'Lokaltog/vim-distinguished'
"Bundle 'chriskempson/vim-tomorrow-theme'
"Bundle 'fisadev/fisa-vim-colorscheme'
"
"
"--------------
"" Color Schemes
"--------------
Bundle 'L9'

Bundle 'scrooloose/syntastic'
Bundle 'FuzzyFinder'



"Bundle 'benmills/vimux'

" CTRL+P
Bundle 'mru.vim'
Bundle 'ctrlp.vim'
"Bundle 'tacahiroy/ctrlp-funky'
"Bundle 'voronkovich/ctrlp-nerdtree.vim'

Bundle 'Lokaltog/vim-powerline'
" Bundle 'xolox/vim-misc'
" Bundle 'xolox/vim-session'
" Bundle 'EasyMotion'


"http://qiita.com/wakuworks/items/5d05f178239a127af33d
" jsctag  https://github.com/mozilla/doctorjs
Bundle 'mihaifm/vimpanel'
" new pane of things
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/tagbar-phpctags'
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'FencView.vim'

Bundle 'The-NERD-Commenter'
"Bundle 'TaskList.vim'
" Solve tab  problem  http://www.haodaima.net/art/2464523
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'tpope/vim-fugitive'
Bundle 'sjl/gundo.vim'
" Bundle 'SirVer/ultisnips'
Bundle 'Shougo/neocomplete'
"Bundle 'jiangmiao/auto-pairs'

"let g:AutoPairs = {'(':')',"'":"'",'"':'"', '`':'`'}
" snippt package
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
" html css snippt
Bundle 'mattn/emmet-vim'
"Bundle 'tpope/vim-surround'
"Bundle 'godlygeek/tabular'
"Bundle 'AutoClose'
"Bundle 'ervandew/supertab'
" super fast motion move
Bundle 'rking/ag.vim'
" Bundle 'dyng/ctrlsf.vim'
"Bundle 'xolox/vim-easytags'
Bundle 'yonchu/accelerated-smooth-scroll'
Bundle 'benmills/vimux'
"Bundle 'terryma/vim-expand-region'
"Bundle 'MattesGroeger/vim-bookmarks'
"Bundle 'kshenoy/vim-signature'
"Bundle 'vim-scripts/TagHighlight'
"Bundle 'xolox/vim-easytags'

filetype plugin indent on
