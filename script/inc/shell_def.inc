<?php

define('UCONF','.beeconf'); // user config file name
define('PCONF','.pconf'); // proj config file name
define('UC_LOC',getenv('HOME').'/'.UCONF);
define("RSYNC_CMD",'rsync -raiv ');
define('VER_URL','https://raw.githubusercontent.com/poyu007/heisoo_env/master/build/hs_bee.ver');
define('','~/.vim/phpctags');

#define("RSYNC_CMD",'rsync -raiv --delete');
date_default_timezone_set('Asia/Shanghai');

function check_version(){
    $date1=strtotime(date('Ymd'));
    $date2=strtotime(_UPDATE_TIME);
    $days=round(($date2 - $date1)/3600/24);
    if($days < -3 ){
        $file = getenv('HOME').'/.ver';
        $shell =  webCall().' -s '.VER_URL.' > '.$file;
        system($shell);
        $version = file_get_contents($file);

       if($version != _VERSION){
            upgrade();
       }

        @unlink($file);
        $_cf=loadConf(UC_LOC);
        $_cf['update_time'] =  date("Ymd");
        saveConf(UC_LOC,$_cf);
    }
}

function upgrade(){
    $git_url ='https://raw.githubusercontent.com/poyu007/heisoo_env/master';
    $cmd= "mkdir -p /usr/local/bin/;curl -s $git_url/build/hs_dBee.phar  > /usr/local/bin/hs_dBee.phar";
    system($cmd);
    $cmd ="curl -s $git_url/dotfiles/vimrc > ~/.vim/vimrc";
    system($cmd);
}


function e_def(){
    $const=get_defined_constants();
    print_r($const);
}

function loadConf($conf){

    if(file_exists($conf)){

        $content = json_decode(file_get_contents($conf),true);
        if(empty($content)) e($conf.'.beeconf format wrong ','red');
        return $content;
    }
    else e($conf.' not exist !!!!!!','red');
}

function conf_to_def($conf){
    foreach($conf as $k => $v){
        define('_'.strtoupper($k),$v);
    }
    define('_DEV', _USER.'@'._DEV_SERVER);

}

function saveConf($conf,$json){
    if(!empty($json)){
        file_put_contents($conf,json_encode($json,JSON_PRETTY_PRINT));
    }
}


function nerdtreeBookMark($proj,$path){
    $NERDtreeConf = getenv('HOME'). '/.NERDTreeBookmarks';
    $content = $proj.' '.$path."\n";
    e($content);
    file_put_contents($NERDtreeConf,$content,FILE_APPEND | LOCK_EX);

}


function define_proj_dir($git_dir,$user,$now_dir){

    $len = strlen($git_dir);

    $left_dir=substr($now_dir,$len+1);
    $raw = explode("/", $left_dir);

    if (strpos($now_dir,$git_dir) === false or count($raw) < 1 or $raw[0] == '') {
        e('Not in project directory  ','red');
    }

    $proj = $raw[0];

    $target='/home/'.$user._PROJ_DIR.'/'.$proj;
    $pconf_loc  = $git_dir.'/'.$proj.'/'.PCONF;
    $pconf_path = $git_dir.'/'.$proj.'/';

    if(!file_exists($pconf_loc)){
        nerdtreeBookMark($proj,$pconf_path);
        proj_conf_setting($target,$pconf_loc,$proj);
    }else{
        $pcf= loadConf($pconf_loc);
        define('PCONF_LOC',$pconf_loc);
        define('PCONF_PATH',$git_dir.'/'.$proj.'/');
        define('_TARGET',$pcf['target']);
    }

}

function conf_setting($setting,$ary = array()){
    $_cf = defaultConf();

    $inst_script  =  get_inst_shell();
    if ($inst_script != '') $_cf['inst_script'] = $inst_script;
    $_cf['setting_time'] =  date("Ymd");
    $_cf['update_time'] =  date("Ymd");

    $_cf = array_merge($_cf,$ary);


    if(file_exists($_cf['git_dir'])){
        saveConf(UC_LOC,$_cf);
    }else{
        e('Git path not exist','red');
    }
}

function proj_conf_setting($target,$loc,$proj){

    e("\n------------------------------  [ ".strtoupper($proj)." ] Setup  -------------------------------\n",'yellow');
    e("Target To:  $target  [y/n]?");

    $pcf= defaultProjConf();
    $yorn = read_stdin();

    if($yorn == 'n') {
        e("Please type target directory !!");
        $pcf['target'] = rtrim(read_stdin(),"/");
    }else if($yorn == 'y'){
        $pcf['target']  = $target;
    }else{
        e("type wrong ,please type [y/n] ",'red');
    }
    saveConf($loc,$pcf);
    e("\n------------------------------  Setup Ending  -------------------------------\n",'yellow');
    exit;

}
function init($init_flag = 0){
    e("\n------------------------------  Client Bee Setup  -------------------------------\n",'yellow');

    e("Process Heisoo Desk bee  script configure setup ! [y/n] !");
    $yorn = read_stdin();
    if($yorn == 'y') {
        e("Initial Local Bee please take few seconds for setup up configuration !");
        e("Your unix name in company ?");
        $user = read_stdin();
        e("Git Directory path ?  now => ".getenv('PWD'));
        $git_dir = read_stdin();
        if(!empty($user) and !empty($git_dir))
            conf_setting(UC_LOC,array('user' => $user ,'git_dir' => $git_dir));
    }else{
        e('type y  if you wanna set up your configuration !','red');
    }

    keygen($user);
    e("\n--------------------------------  End Setup  ------------------------------------\n",'yellow');
}

function run_git_script($url){

    system("curl -L $url | php ",$out);
    e($out);
}
function keygen($user){


    e("\n---------------------------------  important  ---------------------------------\n",'yellow');
    e("Setup ssh keygen [y/n] ? ");
    $yorn = read_stdin();
    if($yorn == 'y'){
        passthru('ssh-keygen -t rsa');
        //$pw = read_stdin();
        $path=getenv('HOME');
        $cmd = 'ssh -t '.$user.'@dev.heisoo.com  "mkdir -p ~/.ssh/"';
        e($cmd,'run');

        $cmd = "scp $path/.ssh/id_rsa $path/.ssh/id_rsa.pub $user@dev.heisoo.com:~/.ssh/";
        e($cmd,'run');
        $cmd = 'ssh -t '.$user.'@dev.heisoo.com  "bee -key"';
        e($cmd,'run');

        //system($cmd, $out);
    }
}
function remote_exec($file,$arg = _PARA){
    $file = realpath($file);
    if(!is_executable($file)){
        e("flle can't execution",'red');
    }
    $rela_file = get_newpos($file);

    $cmd = "ssh -t "._DEV.'  "'.$rela_file.' '.$arg.'"';
    e($cmd);
    system($cmd,$res);
    e($res);
}

function remote_do($do){

    $cmd = "ssh -t "._DEV.'  "cd ~/;'.$do.'"';
    e($cmd);
    system($cmd,$res);
    e($res);
}

function proj_all(){
    $exclude="--exclude '.git' ";
    $exclude.="--exclude 'tags' ";
    $exclude.="--exclude '.DS_Store' ";
    $sync_cmd= RSYNC_CMD.' '.PCONF_PATH.' '._DEV.':'._TARGET.'/ '.$exclude;
    e($sync_cmd,'run');
}
function proj_file($file){

    $file = realpath($file);
    if(!is_file($file)) e('Not a file ','red');

    $rela_file = get_newpos($file);
    $sync_cmd= 'rsync  -raiv  '.$file.' '._DEV.':'.$rela_file;
    e($sync_cmd);
    system($sync_cmd,$res);
    e($res);
}
function get_newpos($file){
    $rela_path = substr($file,strlen(_GIT_DIR)+1);
    $raw = explode("/", $rela_path);
    unset($raw[0]);
    $rela_path = implode('/',$raw);
    return _TARGET.'/'.$rela_path;
}




