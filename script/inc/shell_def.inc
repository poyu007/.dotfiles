<?php

define('UCONF','.beeconf'); // user config file name
define('PCONF','.pconf'); // proj config file name
define('UC_LOC',getenv('HOME').'/'.UCONF);
define("RSYNC_CMD",'rsync -raiv ');
#define("RSYNC_CMD",'rsync -raiv --delete');
date_default_timezone_set('Asia/Shanghai');
$conf = is_file(__DIR__.'/hs_conf.inc') ? __DIR__.'/hs_conf.inc' : __DIR__.'/conf.inc';
include($conf);
function e_def(){
    $const=get_defined_constants();
    print_r($const);
}

function loadConf($conf){
    if(file_exists($conf)) return json_decode(file_get_contents($conf),true);
    else return false;
}

function conf_to_def($conf){
    foreach($conf as $k => $v){
        define('_'.strtoupper($k),$v);
    }
    define('_DEV', _USER.'@'._DEV_SERVER);
}



function saveConf($conf,$json){
    if(!empty($json)) file_put_contents($conf,json_encode($json,JSON_PRETTY_PRINT));
}

function loadProjConf(){

    $len = strlen(_GIT_DIR);
    $left_dir=substr(getenv('PWD'),$len);
    $raw = explode("/", $left_dir);

    if(count($raw) == 0){
        e('directory path wrong'.__LINE__,'red');
    }

    define('PCONF_LOC',_GIT_DIR.'/'.$raw[1].'/'.PCONF);
    define('PCONF_PATH',_GIT_DIR.'/'.$raw[1].'/');
    define('PROJ',$raw[1]);

    $conf = loadConf(PCONF_LOC);
    define('_TARGET',$conf['target']);

    if($conf == false) {
        e($conf.' load fail reset your config using -set !','yellow');
        init();
    }
}

function conf_setting($setting,$ary = array()){
    $_cf = defaultConf();

    $inst_script  =  get_inst_shell();
    if ($inst_script != '') $_cf['inst_script'] = $inst_script;

    if(!is_null($ary)){ 
        $res = array_merge($_cf,$ary);
    }
    saveConf($setting,$res);
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
        e('if you don\'t set up your configuration you can\'t run the program','red');
    }

/*
    e("Load default tmux shell [y/n] ?");
    $yorn = read_stdin();
 */
    //if($yorn = 'y') 
    //
    e("\n--------------------------------  End Setup  ------------------------------------\n",'yellow');
}

function run_git_script($url){

    system("curl -L $url | php ",$out);
    e($out);
}
function keygen(){

    $alert_col="\033[1;31m";
    $normal_col= "\033[0;37m";

    e($alert_col."\n---------------------------------  important  ---------------------------------\n");
    e("Setup ssh keygen [y/n] ? ".$normal_col);
    $yorn = read_stdin();
    if($yorn == 'y'){
        passthru('ssh-keygen -t rsa');
        echo _DEV."'s password ? =>  ";
        $pw = read_stdin();
        system('./exp '._HOME." $pw",$out);
        e($out);
        //system($cmd, $out);
    }
}

function initProj(){

    e("\n------------------------------  Projct Conf setup  -------------------------------\n");

    $target =  '/home/'._USER.'/proj/'.PROJ.'/';
    e('Target directory : '.$target .'okay  !!');

    $_pcf = array(
        'path' => array(

            array( 'from' =>' ', 'to' => ''),
        ),
        'target' => $target,
    );
    saveConf(PCONF_LOC,$_pcf);

    $cmd= 'mkdir -p  /home/'._USER.'/proj/';
    remote_exec($cmd);
    e("\n--------------------------------  End Setup  ------------------------------------\n");
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
    $exclude.="--exclude 'tag' ";
    $exclude.="--exclude '.DS_Store' ";
    $sync_cmd= RSYNC_CMD.' '.PCONF_PATH.' '._DEV.':'._TARGET.' '.$exclude;
    e($sync_cmd,'yellow');
    system($sync_cmd,$out);
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
    $rela_path = substr($file,strlen(_GIT_DIR));
    return '/home/'._USER.'/proj'.$rela_path;
}
