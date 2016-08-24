# Install #
   * curl -S# https://raw.githubusercontent.com/poyu007/heisoo_env/master/build/hs_linux_env.phar > hs_linux_env.phar
   * chmod +x hs_linux_env.phar                                                                                                                                                         ~/src ¥
   * ./hs_linux_env.phar

# hs_sync
    *  hs_sync 是一个把档案推到 dev 环境的 script
    *  有三个参数 -set , -all , -file  , -set 是设定开发环境的位置 , -all 是推 directory 下面所有的档案，-file 是指定档案推过去  

# 采用 vimux （ vim + tmux ) 来
    *  采用 https://github.com/benmills/vimux 来当作 ，debug windows 
# .vimrc
```
function! g:Sync(arg)

    if g:MyTargetFilePath == ''
        echoerr 'Nothing can be sync!'
        return
    endif

    silent !clear
    silent w
    let s:from = expand('%:p')
    let s:path = 'cd '. expand('%:p:h').';'


    if a:arg == 'file'
        let s:cmd = 'hs_sync -file '. s:from
        echo s:cmd
    endif

    if a:arg == 'all'
        let s:cmd = 'hs_sync -all '. s:from
        echo s:cmd
    endif

    if a:arg == 'build'
        let s:cmd = 'hs_sync -build '. s:from
        echo s:cmd
   endif

    "execute ":ConqueTermTab ". s:cmd
    call VimuxRunCommand(s:path . s:cmd)
    execute ":redraw!"
    set background=dark
    colorscheme solarized

endfunction
```

