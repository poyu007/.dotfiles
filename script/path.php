<?php

define('UC_LOC',getenv('HOME').'/.beeconf'); // user config file name
function loadConf($conf){

    if(file_exists($conf)){

        $content = json_decode(file_get_contents($conf),true);
        if(empty($content)) e($conf.'.beeconf format wrong ','red');
        return $content;
    }else{
        return false;
    }
}

$_cf=loadConf(UC_LOC);
if($_cf == false || !isset($argv[1])){
    echo getenv("PWD");
    exit;
}else{
    $git_dir = $_cf['git_dir'];
    $now_dir = $argv[1];

    $len = strlen($git_dir);

    $left_dir=substr($now_dir,$len+1);
    $raw = explode("/", $left_dir);

    if (strpos($now_dir,$git_dir) === false or count($raw) < 1 or $raw[0] == '') {
        echo $git_dir;"
    }else{
        echo $git_dir.'/'.$raw[0];
    }

}



