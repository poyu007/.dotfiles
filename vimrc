source ~/.vim/bundles.vim

" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" enable filetype dectection and ft specific plugin/indent
" filetype plugin indent on

" enable syntax hightlight and completion
syntax on


"--------
"" Vim UI
"--------
" color scheme  
" http://fideloper.com/mac-vim-tmux
set background=dark
let g:solarized_termcolors = 256  " New line!!
colorscheme solarized



au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline 
"set cursorcolumn

" search
set incsearch
"set highlight 	" conflict with highlight current line
set ignorecase
set smartcase

" editor settings
set history=1000
set nocompatible
set nofoldenable                                                  " disable folding"
set confirm                                                       " prompt when existing from an unsaved file
set backspace=indent,eol,start                                    " More powerful backspacing
set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors "
set mouse=a                                                       " use mouse in all modes
set report=0                                                      " always report number of lines changed                "
set nowrap                                                        " dont wrap lines
set scrolloff=5                                                   " 5 lines above/below cursor when scrolling
set number                                                        " show line numbers
set showmatch                                                     " show matching bracket (briefly jump)
set showcmd                                                       " show typed command in status bar
set title                                                         " show file in titlebar
set laststatus=2                                                  " use 2 lines for the status bar
set matchtime=2                                                   " show matching bracket for 0.2 seconds
set matchpairs+=<:>                                               " specially for html
" set relativenumber
set paste
set clipboard=unnamed

" Default Indentation
set autoindent
set smartindent     " indent when
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
" set textwidth=79
" set smarttab
set expandtab       " expand tab to space

" syntax support
"autocmd Syntax javascript set syntax=jquery   " JQuery syntax support
" js
"let g:html_indent_inctags = "html,body,head,tbody"
"let g:html_indent_script1 = "inc"
"let g:html_indent_style1 = "inc"



"-----------------
" Plugin settings
"-----------------
" Nerd Tree 
" https://github.com/scrooloose/nerdtree

let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"
map <C-n> :NERDTreeToggle<CR>


" Nerdcommenter
" http://www.wklken.me/posts/2015/06/07/vim-plugin-nerdcommenter.html
" <leader>c<space>
let NERDSpaceDelims=1
let NERDCompactSexyComs=1
"let mapleader = "," 


" ConqueTerm  
"let g:ConqueTerm_TERM = 'xterm'  
noremap ,tb :ConqueTermVSplit bash<CR>  
  
vnoremap <C-c><C-c> :<C-u>call conque_term#send_selected(visualmode())<CR><Esc><C-w>p  
noremap <C-c><C-c> V:call conque_term#send_selected(visualmode())<CR><Esc><C-w>p  


" ascrooloose/syntastic  check 

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
