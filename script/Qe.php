<?php
include 'inc/basic.inc';
include 'inc/shell_def.inc';
$conf = is_file(__DIR__.'/inc/hs_conf.inc') ? __DIR__.'/inc/hs_conf.inc' : __DIR__.'/inc/conf.inc';
include($conf);

// check user config  exist

$_cf = loadConf(UC_LOC);
$now_dir = getenv('PWD');

define_proj_dir($_cf['git_dir'],$_cf['user'],$now_dir);

conf_to_def($_cf);
if(is_file(PCONF_LOC)){
    $_pcf=loadConf(PCONF_LOC);
}else{
    proj_setting($_cf);
}

check_version();

$arg = '';

if(!startswith($argv[1],'-')){
    remote_do($argv[1]);
}else if($argv[1] == '-add'){
}
