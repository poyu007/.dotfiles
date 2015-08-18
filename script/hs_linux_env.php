<?php
include 'inc/basic.inc';
define('INST_SHELL',get_inst_shell());

e('Install Shell : '.INST_SHELL);



function get_vim_cmd(){
    $dir=_HOME;
    $git_dir='https://raw.githubusercontent.com/poyu007/heisoo_env/master/dotfiles';

    $build_dir='https://raw.githubusercontent.com/poyu007/heisoo_env/master/build';

    if(!is_file("$dir/phpctags")){
        e("curl -S# http://heisoo.oss-cn-qingdao.aliyuncs.com/open/phpctags  > $dir/phpctags",'run');
    }

    return <<<EOF
git clone https://github.com/gmarik/Vundle.vim.git $dir/bundle/vundle/
git clone https://github.com/altercation/vim-colors-solarized.git $dir/bundle/vim-colors-solarized/
curl -S# $git_dir/vimrc > $dir/vimrc
curl -S# $git_dir/tmux.conf > $dir/tmux.conf
curl -S# $git_dir/tmux-user.conf > $dir/tmux-user.conf
curl -S# $git_dir/zshrc > $dir/zshrc
curl -S# $git_dir/bundles.vim > $dir/bundles.vim
curl -S# $build_dir/hs_path.phar > $dir/hs_path.phar
mv ~/.vimrc ~/.vimrc__old
mv ~/.tmux.conf ~/.tmux.conf__old
mv ~/.tmux-user.conf ~/.tmux-user.conf__old
ln -s $dir/vimrc  ~/.vimrc
ln -s $dir/tmux.conf  ~/.tmux.conf
ln -s $dir/tmux-user.conf  ~/.tmux-user.conf
chmod +x $dir/phpctags
chmod +x $dir/hs_path.phar
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


if(getenv('PWD') == '/usr/local/vim'){

    define('_HOME','/usr/local/vim');
    define('_SHARE',true);
}else{
    define('_HOME',getenv('HOME').'/.vim');
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
    $zsh='zsh-5.0.6';

    $cmd = <<<EOF
curl -S#  http://ftp.lfs-matrix.net/pub/blfs/conglomeration/zsh/$zsh.tar.bz2  >  $dir/$zsh.tar.bz2
cd $dir;tar xvjf $zsh.tar.bz2;cd $dir/$zsh;./configure && make && sudo make install
rm -rf $dir/$zsh.*
EOF;
    run_cmds($cmd);

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
        $cmd=('yum install ncurses-devel;sudo yum install autojump');
        inst_zsh();
        e($cmd,'run');
    }

    $cmd= "curl -L# http://install.ohmyz.sh > ".getenv('HOME')."install.ohmyz.sh;sh ".getenv('HOME')."install.ohmyz.sh;rm ".getenv('HOME').'/install.ohmyz.sh';
    e($cmd,'run');
    $cmd = "mv ~/.zshrc ~/.zshrc__old;ln -s "._HOME."/zshrc ~/.zshrc";
    e($cmd,'run');
    e('cd '._HOME.';git clone git://github.com/joelthelion/autojump.git;cd autojump;./install.py','run');

}

e("Change your shell to zsh  ! [y/n] !");
$yorn = read_stdin();
if($yorn == 'y'){
    system('chsh -s /bin/zsh;source ~/.zshrc');
}

e("Install heisoo tools!");
$incFile= '/usr/local/heisoo/Qe.phar';
$cmd= "sudo mkdir -p ".HS_LIB.";sudo mkdir -p /usr/local/bin/;curl -L# https://raw.githubusercontent.com/poyu007/heisoo_env/master/build/Qe.phar  > ./Qe.phar;sudo mv ./Qe.phar $incDir;sudo chmod +x $incFile; ln -s ".HS_LIB."/Qe.phar /usr/local/bin/$incFile;";
e($cmd,'run');
# ln -s $dir/tmux.conf ~/.tmux.conf`;
# #brew install ctags # vim +PluginInstall +qall now
