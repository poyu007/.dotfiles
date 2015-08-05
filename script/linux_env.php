<?php
include 'inc/basic.inc';
ob_start();
define('INST_SHELL',get_inst_shell());
ob_end_clean();
e('Install Shell : '.INST_SHELL);



function get_vim_cmd(){
    $dir=_HOME;
    $git_dir='https://raw.githubusercontent.com/poyu007/heisoo_env/master/dotfiles';

    if(defined('_SHARE')){
        e("curl -S# $git_dir/share_bundles.vim > $dir/bundles.vim",'run');
    }else{
        e("curl -S# $git_dir/bundles.vim > $dir/bundles.vim",'run');
    }



    return <<<EOF
git clone https://github.com/gmarik/Vundle.vim.git $dir/bundle/vundle/
git clone https://github.com/altercation/vim-colors-solarized.git $dir/bundle/vim-colors-solarized/
curl -S# $git_dir/vimrc > $dir/vimrc
curl -S# $git_dir/tmux.conf > $dir/tmux.conf
curl -S# $git_dir/zshrc > $dir/zshrc
mv ~/.vimrc ~/.vimrc__old
mv ~/.tmux.conf ~/.tmux.conf__old
ln -s $dir/vimrc  ~/.vimrc
ln -s $dir/tmux.conf  ~/.tmux.conf
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/undo
curl -S# http://heisoo.oss-cn-qingdao.aliyuncs.com/open/phpctags  > $dir/phpctags
chmod +x $dir/phpctags
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

function run_cmds($cmds){
    $cmd_ary = explode("\n", $cmds);
    foreach($cmd_ary as $cmd){
        if(!empty($cmd )){
            e($cmd);
            system($cmd);
        }
    }
}

e("Setup for 1. Single user  ( put vim in your home directory )  or 2. Multiple users  (put vim in /usr/loca/ directory) ? [1/2]   ");
$yorn = read_stdin();
if($yorn == '1'){
    define('_HOME',getenv('HOME').'/.vim');
}else if($yorn == '2'){
    define('_HOME','/usr/local/vim');
    define('_SHARE',true);

}
e("Process vim setup  ! [y/n] !");
$yorn = read_stdin();
if($yorn == 'y'){
    $cmds = get_vim_cmd();
    run_cmds($cmds);
    inst_ctag();
}
function inst_zsh(){
    $dir=_HOME;

    $cmd = <<<EOF
curl -S# http://sourceforge.net/projects/zsh/files/zsh/5.0.2/zsh-5.0.2.tar.bz2/download  >  $dir/zsh-5.0.2.tar.bz2
cd $dir;tar xvjf zsh-5.0.2.tar.bz2;cd zsh-5.0.2;./configure && make && sudo make install
EOF;

}
e("Process zsh jump setup   ! [y/n] !");
$yorn = read_stdin();
if($yorn == 'y'){
    if(INST_SHELL == 'brew'){
        inst_zsh();
    }elseif(INST_SHELL == 'apt-get'){
        $cmd ="sudo apt-get install zsh git-core";
        e($cmd,'run');
    }elseif(INST_SHELL == 'yum' ){
        inst_zsh();
        $cmd=('sudo yum install autojump');
        e($cmd,'run');
    }

    $cmd= "curl -L# http://install.ohmyz.sh > ".getenv('HOME')."install.ohmyz.sh;sh ".getenv('HOME')."install.ohmyz.sh;rm ".getenv('HOME').'/install.ohmyz.sh';
    e($cmd,'run');
    $cmd = "mv ~/.zshrc ~/.zshrc__old;ln -s "._HOME."/zshrc ~/.zshrc";
    e($cmd,'run');
    e('cd '._HOME.';git clone git://github.com/joelthelion/autojump.git;cd autojump;./install.py','run');
    e('curl -S# https://raw.githubusercontent.com/joelthelion/autojump/master/bin/autojump.zsh -O > '._HOME.'/autojump.zsh','run');
    e("sed -i 's/--add/-a/g' "._HOME.'/autojump.zsh','run');
    e('sudo cp '._HOME.'/autojump.zsh '.'/etc/profile.d/autojump.zsh','run');

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
