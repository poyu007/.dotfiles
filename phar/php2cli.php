<?php
include('basic.inc');
$version = '1.0.0';
$prefix='hs_';

if (!Phar::canWrite()) {
    die("Phar is in read-only mode, try php -d phar.readonly=0 cli/create.php\n");
}
if(count($argv) !=  3 ){
    e("no arguament -\$action -\$file ");
    exit;
}else{
    
    $cmd = $argv[1];
    $file_name = $argv[2];
    $real_file = realpath($file_name); 
    $path_vars =  pathinfo($file_name);
    $_dir = $path_vars['dirname'];
}

if(!is_file($file_name)){
    e("file not exit ".$_dir.$argv[2]);
    exit;
}else{
    $row=explode('.',$file_name);
    $phar_name=$prefix.$row[0].'.phar';
    $script=$prefix.$row[0];
    $verion_file=$prefix.$row[0].'.ver';
}



$p = new Phar($_dir. '/'.$phar_name, 0, $phar_name);
$p->buildFromDirectory($_dir,'/\.php$|\.inc$/');
$stub = <<<EOD
#!/usr/bin/env php
<?php
Phar::interceptFileFuncs();
\$path ="phar://" . __FILE__ . "/$file_name";
include "\$path";
__HALT_COMPILER();
EOD;
$p->setStub($stub);
chmod($_dir. '/'.$phar_name,0755);
file_put_contents($verion_file,$version);
//system("mv $name $script;
if($cmd == '-new'){
    e("mv $phar_name ../build/;mv $verion_file ../build/");
}
?>
