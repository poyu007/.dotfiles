<?php

include 'inc/basic.inc';
include 'inc/shell_def.inc';
// check user config  exist
$_cf = loadConf(UC_LOC);
if(!isset($_cf)) {
    init();
    exit;
}
//loading config
conf_to_def($_cf);
$_pcf=loadProjConf();


if(count($argv) < 2 ){
    e('miss parameter type -set , -dir ,-run, -do, -file, -add, -bind','red');

}else{
    $arg = '';
    $num = count($argv);
    for($i=3; $i< $num ; $i++){
        $arg .= $argv[$i].' ';
    }

}

if($argv[1] == '-set'){
    init();
}else if($argv[1] == '-dir'){
    proj_all();

}else if($argv[1] == '-run'){

    if(!isset($argv[2])){
        e('Warning : need push file','red');
    }

    $file= $argv[2];

    proj_file($file);
    remote_exec($file,$arg);
} else if($argv[1] == '-do'){
    if(!isset($argv[2])) e('Warning : need cmd','red');
    remote_do($argv[2]);
}else if($argv[1] == '-file'){

    $file = is_file($argv[2]) ? $argv[2] : e('file not exist',true);
    proj_file($file);

}else if($argv[1] == '-add'){
}else if($argv[1] == '-bind'){
}

?>
