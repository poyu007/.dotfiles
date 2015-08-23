<?php
include 'inc/basic.inc';
include 'inc/shell_def.inc';
$conf = is_file(__DIR__.'/inc/hs_conf.inc') ? __DIR__.'/inc/hs_conf.inc' : __DIR__.'/inc/conf.inc';
include($conf);

// check user config  exist
if(!isset($argv[1])){
    e('miss parameter type -set , -all , -file','red');
}else if(file_exists(UC_LOC) == false or $argv[1] == '-set') {
    init();
    exit;
}else if(!isset($argv[2])){
    e('miss 2 parameter ','red');
}
$source = realpath($argv[2]);

$_cf = loadConf(UC_LOC);
$now_dir= (isset($argv[2])) ? $source : getenv('PWD');

define_proj_dir($_cf['git_dir'],$_cf['user'],$now_dir);


//loading config
conf_to_def($_cf);
if(is_file(PCONF_LOC)){
    $_pcf=loadConf(PCONF_LOC);
}else{
    proj_setting($_cf);
}

check_version();


if($argv[1] == '-all'){
    proj_all();
}else if($argv[1] == '-file'){
    $file = is_file($argv[2]) ? $argv[2] : e('file not exist','red');
    proj_file($file);
}else if($argv[1] == '-tag'){

    $cmd ='cd '.PCONF_PATH.';'.PHPTAGS.' -R */*/*;mv tags ~/.vim/tags;';
    ($cmd);

}

