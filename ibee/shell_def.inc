<?php

define('UCONF','.beeconf'); // user config file name
define('PCONF','.pconf'); // proj config file name
define('UC_LOC',getenv('HOME').'/'.UCONF);
define('VIM_SHELL','https://raw.githubusercontent.com/poyu007/.dotfiles/master/script/vim_ide');
define("RSYNC_CMD",'rsync -raiv --delete');

date_default_timezone_set('Asia/Shanghai');

function e_def(){
    $const=get_defined_constants();
    print_r($const);
}

function loadConf($conf){
    if(file_exists($conf)) return json_decode(file_get_contents($conf),true);
    else false;
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

function e($echo,$error=false){
    if(!$error){
        if(count($echo) > 0){
            print_r($echo)."\n";
        }else echo $echo."\n";
    }else{
        echo 'Message error '.$echo."\n";
        exit;
    }
}

function loadProjConf(){

    $len = strlen(_GIT_DIR);
    $left_dir=substr($_ENV['PWD'],$len);
    $raw = explode("/", $left_dir);

    if(count($raw) == 0){
        e('directory path wrong'.__LINE__,true);
    }

    define('PCONF_LOC',_GIT_DIR.'/'.$raw[1].'/'.PCONF);
    define('PCONF_PATH',_GIT_DIR.'/'.$raw[1].'/');
    define('PROJ',$raw[1]);


    $conf = loadConf(PCONF_LOC);
    define('_TARGET',$conf['target']);

    if(!empty($conf)) return $conf;
    initProj();

}
function user_setting($setting,$ary = array()){

    $_cf = array(
        'user' => 'josh',
        'dev_server' => 'dev.heisoo.com',
        'stage_server' => 'staging.heisoo.com',
        'git_dir' => '/Users/macbook/src',
        'home' => getenv('HOME'),
    );

    $found = (strpos($_ENV['SSH_AUTH_SOCK'],'apple') !== false);
    if ($found) $_cf['device'] ='apple';
    $_cf['time'] =   date("Y-m-d H:i:s");

    if(!is_null($ary)){ 
        echo '------------------------';
        $res = array_merge($_cf,$ary);
    }
    saveConf($setting,$res);
}

function read_stdin()
{
    $fr=fopen("php://stdin","r");   // open our file pointer to read from stdin
    $input = fgets($fr,128);        // read a maximum of 128 characters
    $input = rtrim($input);         // trim any trailing spaces.
    fclose ($fr);                   // close the file handle
    return $input;                  // return the text entered
}

function init($init_flag = 0){
    e("\n------------------------------  Client Bee Setup  -------------------------------\n");

    e("Process B  script configure setup ! [y/n] !");
    $yorn = read_stdin();
    if($yorn == 'y') {
        e("Initial Local Bee please take few seconds for setup up configuration !");
        e("Your unix name in company ?");
        $user = read_stdin();
        e("Git Directory path ?  now => ".$_ENV['PWD']);
        $git_dir = read_stdin();
        if(!empty($user) and !empty($git_dir)) 
            user_setting(UC_LOC,array('user' => $user ,'git_dir' => $git_dir));
    }

    e("Load default vim plugin shell [y/n] ?");
    $yorn = read_stdin();
    if($yorn == 'y') run_git_script(VIM_SHELL);
/*
    e("Load default tmux shell [y/n] ?");
    $yorn = read_stdin();
*/
    //if($yorn = 'y') 
    //
    e("\n--------------------------------  End Setup  ------------------------------------\n");
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
    sleep(1);

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

function remote_exec($file,$arg){
    $file = realpath($file);
    if(!is_executable($file)){
        e("flle can't execution",true); 
    }
    $rela_file = get_newpos($file);

    $cmd = "ssh -t "._DEV.'  "'.$rela_file.' '.$arg.'"';
    e($cmd);
    system($cmd,$res);
    e($res);
}

function proj_all($conf){
    $exclude="--exclude '.git' ";
    $exclude.="--exclude 'tag' ";
    $sync_cmd= RSYNC_CMD.' '.PCONF_PATH.' '._DEV.':'.$conf['target'].' '.$exclude;
    system($sync_cmd,$out);
    e($out);
}
function proj_file($file){

    $file = realpath($file);
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
