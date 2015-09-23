<?php
define('_VERSION','1.0.2');
define('_VERSION_FILE','hs_bee.ver');
define('_PROJ_DIR','/proj');

function defaultConf(){
    return array(
        'dev_server' => 'dev.heisoo.com',
        'stage_server' => 'staging.heisoo.com',
        'home' => getenv('HOME'),
    );
}

function defaultProjConf(){
    return array(
        'path' => array(

            array( 'from' =>' ', 'to' => ''),
        ),
        'target' => '',
        'work_server' => 'dev.heisoo.com',
    );

}


