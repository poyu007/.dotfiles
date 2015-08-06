<?php

define('UCONF','.beeconf'); // user config file name
define('PCONF','.pconf'); // proj config file name
define('UC_LOC',getenv('HOME').'/'.UCONF);
define("RSYNC_CMD",'rsync -raiv ');
define('VER_URL','https://raw.githubusercontent.com/poyu007/heisoo_env/master/build/hs_bee.ver');

#define("RSYNC_CMD",'rsync -raiv --delete');
date_default_timezone_set('Asia/Shanghai');

function check_version(){
    $date1=strtotime(date('Ymd')); 
    $date2=strtotime(_UPDATE_TIME);
    $days=round(($date2 - $date1)/3600/24) ;
    if($days < -7 ){
        $file = getenv('HOME').'/.ver';
        $shell =  webCall().' -s '.VER_URL.' > '.$file;
        e($shell);
        $out = `$shell`;
        $verion = file_get_contents($file);
        print_r($verion);
        if($verion != _VERSION){
            upgrade();
            @unlink($file);
            $_cf=loadConf(UC_LOC);
            $_cf['update_time'] =  date("Ymd");
            saveConf(UC_LOC,$_cf);
        }
    }

}

function upgrade(){
    $cmd= "mkdir -p /usr/local/bin/;curl -L# https://raw.githubusercontent.com/poyu007/heisoo_env/master/build/hs_dBee.phar  > /usr/local/bin/hs_Dbee.phar"; 
    e($cmd,'run');
}



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


    define_proj_dir($conf['git_dir'],$conf['user']);
}



function saveConf($conf,$json){
    if(!empty($json)){
        file_put_contents($conf,json_encode($json,JSON_PRETTY_PRINT));
    }
}


function define_proj_dir($dir,$user){

    $len = strlen($dir);
    $left_dir=substr(getenv('PWD'),$len);
    $raw = explode("/", $left_dir);

    if(count($raw) == 0){
        e('directory path wrong'.__LINE__,'red');
    }

    define('PCONF_LOC',$dir.'/'.$raw[1].'/'.PCONF);
    define('PCONF_PATH',$dir.'/'.$raw[1].'/');
    define('PROJ',$raw[1]);
    define('_TARGET','/home/'.$user._PROJ_DIR.'/'.PROJ.'/');



}

function conf_setting($setting,$ary = array()){
    $_cf = defaultConf();

    $inst_script  =  get_inst_shell();
    if ($inst_script != '') $_cf['inst_script'] = $inst_script;
    if (defined('_VERSION')){
        $_cf['inst_version'] = _VERSION;
    }
    $_cf['setting_time'] =  date("Ymd");
    $_cf['update_time'] =  date("Ymd");

    $_cf = array_merge($_cf,$ary);

    saveConf(UC_LOC,$_cf);
    define_proj_dir($_cf['git_dir'],$_cf['user']);

    if(file_exists(PCONF_PATH)){
        saveConf(PCONF_LOC,defaultProjConf(_TARGET));
    }else{
        unlink(UC_LOC);
        e('Git path not exist','red');
    }
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






