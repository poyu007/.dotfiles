<?php
include 'shell_def.inc';
// check user config  exist
$_cf = loadConf(UC_LOC);
if(!isset($_cf)) {
    init();
    exit;
}
//loading config
conf_to_def($_cf);
$_pcf=loadProjConf();



if($argv[1] == '-set'){
    init();
}else if($argv[1] == '-dir'){
    proj_all($_pcf);


}else if($argv[1] == '-run'){
    $file= $argv[2];

    $arg = '';
    $num = count($argv);
    for($i=3; $i< $num ; $i++){



        $arg .= $argv[$i].' ';
    }

    proj_file($file);
    remote_exec($file,$arg);
}else if($argv[1] == '-file'){
    $file = is_file($argv[2]) ? $argv[2] : e('file not exist',true);
    proj_file($file);

}else if($argv[1] == '-add'){
}else if($argv[1] == '-bind'){
}

?>
