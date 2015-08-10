
"""""""""""""""""""""""""""""""""""""""""""""""""
" default
"""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" 编码
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set history=400   " keep 400 lines of command line history

syntax enable
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

set backspace=indent,eol,start    " allow backspacing over everything in insert mode
" 显示光标位置
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching
set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m
" Don't use Ex mode, use Q for formatting
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


if isdirectory("/usr/local/vim/vundle")
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
Bundle 'tacahiroy/ctrlp-funky'
"Bundle 'voronkovich/ctrlp-nerdtree.vim'

Bundle 'Lokaltog/vim-powerline'
" Bundle 'xolox/vim-misc'
" Bundle 'xolox/vim-session'
" Bundle 'EasyMotion'


"Bundle 'vim-scripts/taglist.vim'
"http://qiita.com/wakuworks/items/5d05f178239a127af33d
" jsctag  https://github.com/mozilla/doctorjs
Bundle 'mihaifm/vimpanel'

" new pane of things
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/tagbar-phpctags'
Bundle 'scrooloose/nerdtree'
Bundle 'FencView.vim'

Bundle 'The-NERD-Commenter'
Bundle 'TaskList.vim'
" Solve tab  problem  http://www.haodaima.net/art/2464523
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'tpope/vim-fugitive'

" Bundle 'SirVer/ultisnips'
"Bundle 'Shougo/neocomplete'
Bundle 'Shougo/neocomplcache'
" snippt package
Bundle 'Shougo/neosnippet'
Bundle 'Shougo/neosnippet-snippets'
" html css snippt
Bundle 'mattn/emmet-vim'
Bundle 'tpope/vim-surround'
"Bundle 'godlygeek/tabular'
"Bundle 'AutoClose'
"Bundle 'ervandew/supertab'
" super fast motion move
Bundle 'rking/ag.vim'
" Bundle 'dyng/ctrlsf.vim'
"Bundle 'xolox/vim-easytags'
Bundle 'yonchu/accelerated-smooth-scroll'
Bundle 'benmills/vimux'
Bundle 'terryma/vim-expand-region'
"Bundle 'MattesGroeger/vim-bookmarks'
"Bundle 'kshenoy/vim-signature'
"Bundle 'vim-scripts/TagHighlight'
"Bundle 'xolox/vim-easytags'

filetype plugin indent on



