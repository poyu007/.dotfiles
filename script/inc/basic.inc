<?php

function e($p,$code ='green'){

    $color =  array(
        'green' => "\033[1;32m",
        'white' => "\033[0;37m",
        'red' => "\033[0;31m",
        'yellow' => "\033[0;33m",
    );

    if($code == 'red'){
        echo $color[$code].'Error:  '.$p."\n".$color['white'];
        exit;
    }else if(is_array($p)){
        print_r($p);
    }else if($code == 'run'){
        echo $color['green'].'Run ->  '.$p.$color['white']."\n";
        system($p,$out);
        return $out;
        $color['green'].$out.$color['white']."\n";
    }else{
        echo $color[$code].' '.$p.$color['white']."\n";
   }
}

function read_stdin()
{
    $fr=fopen("php://stdin","r");   // open our file pointer to read from stdin
    $input = fgets($fr,128);        // read a maximum of 128 characters
    $input = rtrim($input);         // trim any trailing spaces.
    fclose ($fr);                   // close the file handle
    return $input;                  // return the text entered
}

function get_inst_shell(){
    $cmd="which apt-get";
    $cmd_out = exec($cmd);
    $shell ='';

    if (!preg_match("/not |no /i",$cmd_out)) {
        $shell = 'apt-get';
    }

    $cmd="which brew";
    $cmd_out = exec($cmd);

    if (!preg_match("/not |no /i",$cmd_out)) {
        $shell = 'brew';
    }

    $cmd="which yum";
    $cmd_out = exec($cmd);

    if (!preg_match("/not |no /i",$cmd_out)) {
        $shell = 'yum';
    }
    return $shell;
}
function webCall(){
    $cmd="which wget";
    $cmd_out = chop(`$cmd`);
    $shell ='';
    if (!preg_match("/no /i",$cmd_out)) {
        $shell = 'wget';
    }
    $cmd="which curl";
    $cmd_out = chop(`$cmd`);

    if (!preg_match("/no /i",$cmd_out)) {
        $shell = 'curl';
    }
    return $shell;


}
?>
