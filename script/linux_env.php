<?php
include 'inc/basic.inc';



function get_vim_cmd(){
    $dir=_HOME.'/.vim';
    $home = _HOME;
    $c_dir='tmp_ctags';
    $git_dir='https://raw.githubusercontent.com/poyu007/heisoo_env/master/dotfiles';

    return <<<EOF
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle/
git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized/
curl -S $git_dir/vimrc > $dir/vimrc
curl -S $git_dir/bundles.vim > $dir/bundles.vim
curl -S $git_dir/bundles.vim > $dir/tmux.conf
curl -S $git_dir/zshrc > $dir/zshrc
mv ~/.vimrc ~/.vimrc__old
ln -s $dir/vimrc  ~/.vimrc
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/undo
curl -S http://heisoo.oss-cn-qingdao.aliyuncs.com/open/phpctags  > ~/.vim/phpctags
chmod +x ~/.vim/phpctags
EOF;
}



function inst_ctag(){

    if(INST_SHELL == 'apt-get'){
        e($cmd);
        e('sudo apt-get install curl','run');
        e('sudo apt-get install exuberant-ctags','run');
        e('apt-get install silversearcher-ag','run');
    }
    if(INST_SHELL == 'brew'){
        e($cmd);
        e('brew install curl','run');
        e('brew install ctags-exuberant','run');
        e('brew install the_silver_searcher','run');
    }
}
function get_zsh_cmd(){
    $path =_HOME.'/tmp_shell';
    $home =_HOME;

    return <<<EOF
mkdir -p $path
curl -S http://www.zsh.org/pub/
curl -S# http://heisoo.oss-cn-qingdao.aliyuncs.com/open/zsh-5.0.8.tar.bz2 >  $path/zsh-5.0.8.tar.bz2
cd $path;tar --strip-components=1 -xvf zsh-5.0.8.tar.bz2; ./configure --prefix=/usr --bindir=/bin --sysconfdir=/etc/zsh --enable-etcdir=/etc/zsh
cd $path;make;makeinfo  Doc/zsh.texi --plaintext -o Doc/zsh.txt;makeinfo  Doc/zsh.texi --html -o Doc/html;makeinfo  Doc/zsh.texi --html --no-split --no-headers -o Doc/zsh.html
cd $path;git clone git://github.com/joelthelion/autojump.git
cd $path/autojump;chmod 755 install.py; /install.py
curl -L   https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
rm -rf $path;
EOF;
}

function run_cmds($cmds){
    $cmd_ary = explode("\n", $cmds);
    foreach($cmd_ary as $cmd){
        if(!empty($cmd )){
            e($cmd);
            system($cmd);
        }
    }
}

define('_HOME',chop(system('echo $HOME')));
define('INST_SHELL',get_inst_shell());
e("Process vim setup  ! [y/n] !");
$yorn = read_stdin();
if($yorn == 'y'){
    $cmds = get_vim_cmd();
    run_cmds($cmds);
    inst_ctag();
}

e("Process zsh jump setup   ! [y/n] !");
$yorn = read_stdin();
if($yorn == 'y'){
    if(INST_SHELL == 'brew'){
        $cmds = get_zsh_cmd($_ENV['HOME']);
        run_cmds($cmds);
    }elseif(INST_SHELL == 'apt-get'){
        $cmd ="sudo apt-get install zsh git-core";
        e($cmd,'run');
        $cmd= "curl -L# http://install.ohmyz.sh > ~/.vim/install.ohmyz.sh;sh ~/.vim/install.ohmyz.sh"; 
        e($cmd,'run');
    }

    $cmd = "mv ~/.zshrc ~/.zshrc__old;ln -s "._HOME."/.vim/zshrc ~/.zshrc";
    e($cmd);
    system($cmd);

}

e("Change your shell to zsh  ! [y/n] !");
$yorn = read_stdin();
if($yorn == 'y'){
    system('chsh -s /bin/zsh;source ~/.zshrc');
}

e("Install hs_Dbee !");
$cmd= "mkdir -p /usr/local/bin/;curl -L# https://raw.githubusercontent.com/poyu007/heisoo_env/master/build/hs_dBee.phar  > /usr/local/bin/hs_Dbee.phar"; 
e($cmd,'run');

# ln -s $dir/tmux.conf ~/.tmux.conf`;

# #brew install ctags # vim +PluginInstall +qall now
