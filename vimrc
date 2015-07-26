""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""
source ~/.vim/bundles.vim 
"

"filetype plugin indent on
"

" Platform
function! MySys()
	if has("win32") || has("win64")
	return "windows"
elseif has("mac")
	return "mac"
else
	return "linux"
endif
endfunction

" Move Backup Files to ~/.vim/backups/
set backupdir=~/.vim/backups
set dir=~/.vim/backups
set nobackup
set undodir=~/.vim/undos
set undofile

set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors "
set laststatus=2   " Always show the statusline
set ambiwidth=single
set clipboard=unnamed
set expandtab
" 行间距
set linespace=4
" 显示行号
set number
" 用 <> 调整缩进的长度
set shiftwidth=4
" tab 符的长度
set tabstop=4
set softtabstop=4

" 行号栏的宽度
set numberwidth=4
" 禁止自动换行
set nowrap
set wildmenu
set wildmode=longest:full,full
" set wildignore+=*.orig,*.pyc
" 分割窗口时 保持相等的宽/高
set equalalways
" 匹配括号的规则，增加了针对HTML的<>
set matchpairs=(:),{:},[:],<:>
" 退格、空格、上下箭头 遇到 行首 行尾 时 自动移动下一行(包括insert模式)
set whichwrap=b,s,<,>,[,]
set foldmethod=marker
set diffopt+=iwhite,vertical " 忽略缩进的差异

""""""""""""""""""""""""""""""""""""""""
" vim  UI
""""""""""""""""""""""""""""""""""""""""
"" color scheme
" http://fideloper.com/mac-vim-tmux
"
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if has("gui_running") || has("gui_macvim")
	colorscheme obsidian2
	let g:colors_name="obsidian2"
else
"	colorscheme molokai
"
    let g:solarized_termcolors=256
    syntax enable
    set background=dark
    colorscheme solarized
"
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype and syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:javascript_enable_domhtmlcss=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_macvim")	" 取消默认的快捷键
	let macvim_skip_cmd_opt_movement = 1
	let macvim_hig_shift_movement = 1
	" 设置背影透明度
	set transparency=9
	" 隐藏工具栏
	set guioptions-=T 

endif

" autocmd
autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd! VimEnter *  :silent !~/.vim/phpctags -R *

" filetype
autocmd BufNewFile,BufRead jquery.*.js set ft=javascript syntax=jquery
autocmd BufNewFile,BufRead *.md setlocal ft=markdown
autocmd BufNewFile,BufRead *.scss set ft=scss

" Language support
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=80
autocmd FileType css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 设置 <leader> 快捷键
let mapleader=","
let g:mapleader=","

map <silent> <leader>rc :tabe ~/.vimrc<cr>
map <leader>q :q<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NREDTree setting
let g:NERDTreeWinSize = 20
nmap <silent> <leader>nt :call OpenNERDTree()<cr>

function! OpenNERDTree()
	" let tmp = g:eighties_minimum_width
	let g:eighties_minimum_width = 20
	:NERDTree
	" let g:eighties_minimum_width = tmp
endfunction

" eighties
let g:eighties_enabled = 1
let g:eidthies_minimum_width = 80
let g:eighties_extra_width = 0
let g:eighties_compute = 1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDChristmasTree=0
" Syntastic


let g:syntastic_javascript_checkers = ['jshint']
let g:loaded_html_syntax_checked = 1
let g:syntastic_auto_loc_list=0

" tasklist
nmap <silent> <leader>tl <Plug>TaskList

" tagbar
let g:tagbar_width = 20
let g:tagbar_singleclick = 1
let g:tagbar_iconchars = ['▾', '▸']
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
nnoremap <leader>tb :TagbarToggle<CR>

" session
let g:session_autoload = 'no'
nnoremap <leader>ss :SaveSession
nnoremap <leader>so :OpenSession
nnoremap <leader>sd :DeleteSession
nnoremap <leader>sc :CloseSession<cr>
nnoremap <leader>sv :ViewSession<cr>

" ctrl-p MRU + ctrlp
let g:ctrlp_working_path_mode=2 " .git/ .hg/ .svn/ .bzr/ _darcs/ or your own marker_dir/ marker_file
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = ':CtrlPMRU'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_user_command = 'find %s -type f'  

let g:Powerline_symbols = 'compatible'

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" neocomplcache
" Use neocomplcache
let g:neocomplcache_enable_at_startup = 1
" Use smartcase
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length
let g:neocomplcache_min_syntax_length = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_manual_completion_start_length = 1
let g:neocomplcache_max_list = 20

" html5
let g:html5_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
let g:aria_attributes_complete = 0


" " easymotion 
" let g:EasyMotion_smartcase = 1
" let g:EasyMotion_leader_key = ','
" let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" map <Leader><leader>h <Plug>(easymotion-linebackward)
" " map <Leader><Leader>j <Plug>(easymotion-j)
" " map <Leader><Leader>k <Plug>(easymotion-k)
" map <Leader><leader>l <Plug>(easymotion-liGneforward)
"  重复上一次操作, 类似repeat插件, 很强大
" map <Leader><leader>. <Plug>(easymotion-repeat)




"xnoremap p pgvy

"  phpctags 
"let g:tagbar_phpctags_bin='~/.vim/phpctags'
 "

" neosnippet Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Yank text to the OS X clipboard" 将文本复制到OS X剪贴板中
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>
" noremap <leader>y "*y
" noremap <leader>yy "*Y
 



if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif
