
"""""""""""""""""""""""""""""""""""""""""""""""""
" default
"""""""""""""""""""""""""""""""""""""""""""""""""
"{{{  ---- default setting
set nocompatible
"==========================================
" Basic infomation Settings 文件编码,格式
"==========================================
" 设置新文件的编码为 UTF-8
set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn
set hidden
set termencoding=utf-8
set history=1000   " keep 400 lines of command line history
set scrolloff=5  " 往下移动会留  5  格
" Use Unix as the standard file type
set ffs=unix,dos,mac
syntax enable
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
set t_Co=256       " Explicitly tell vim that the terminal has 256 colors "
set linespace=4    " 行间距
set laststatus=2   " Always show the statusline
set ambiwidth=single
set clipboard=unnamed
set expandtab
set ttyfast       " Vim Scrolling Slowly
set autoindent    " 打开自动缩进
set formatoptions+=B
set ambiwidth=single
set wrap linebreak
set whichwrap=b,s,<,>,[,]
set showbreak=↪
set backspace=eol,start,indent      " allow backspacing over everything in insert mode
set viminfo^=%
" 显示光标位置
set ruler                           " show the cursor position all the time
set showcmd                         " display incomplete commands
set number
" tab相关变更
set tabstop=4     " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4  " 每一次缩进对应的空格数
set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab     " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
" Searching
set ignorecase " 有一个或以上大写字母时仍大小写敏感
set incsearch " 搜索时忽略大小写
set smartcase
set showmatch
set hlsearch  " 打开增量搜索模式,随着键入即时搜索

set diffopt+=iwhite,vertical " 忽略缩进的差异
set shortmess=a

set matchpairs=(:),{:},[:],<:>
set matchtime=2 " 括号配对情况,跳转并高亮一下匹配的括号
" 自动补全配置
"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu
" 增强模式中的命令行自动完成操作
set wildmenu
set wildmode=longest:full,full
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class


set equalalways  " 分割窗口时 保持相等的宽/高
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline
set cursorcolumn

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" }}}  ---- default setting
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
"Bundle 'FuzzyFinder'



"Bundle 'benmills/vimux'

" CTRL+P
Bundle 'mru.vim'
Bundle 'ctrlp.vim'
"Bundle 'tacahiroy/ctrlp-funky'
"Bundle 'voronkovich/ctrlp-nerdtree.vim'


Bundle 'junegunn/vim-easy-align'
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
Bundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'unicode'
" Bundle 'xolox/vim-misc'
" Bundle 'xolox/vim-session'
" Bundle 'EasyMotion'

"http://qiita.com/wakuworks/items/5d05f178239a127af33d
" jsctag  https://github.com/mozilla/doctorjs

"Bundle 'mihaifm/vimpanel'

" new pane of things
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/tagbar-phpctags'
Bundle 'scrooloose/nerdtree'
" {{{
let NERDTreeShowBookmarks       = 1
let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore              = [ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" }}}
"for minibufferexpl
Bundle 'fholgado/minibufexpl.vim'
" {{{
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
"解决FileExplorer窗口变小问题
let g:miniBufExplForceSyntaxEnable = 1
let g:miniBufExplorerMoreThanOne=2
let g:miniBufExplCycleArround=1
" }}}
"Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'FencView.vim'

"Bundle 'The-NERD-Commenter'
"Bundle 'TaskList.vim'
" Solve tab  problem  http://www.haodaima.net/art/2464523
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'tpope/vim-fugitive'

" Bundle 'SirVer/ultisnips'
Bundle 'Shougo/neocomplete'
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
Bundle 'sjl/gundo.vim'
" Bundle 'dyng/ctrlsf.vim'
"Bundle 'xolox/vim-easytags'
Bundle 'yonchu/accelerated-smooth-scroll'
Bundle 'benmills/vimux'
"Bundle 'terryma/vim-expand-region'
"Bundle 'MattesGroeger/vim-bookmarks'
"Bundle 'kshenoy/vim-signature'
"Bundle 'vim-scripts/TagHighlight'

filetype plugin indent on

