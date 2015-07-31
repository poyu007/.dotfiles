<?php

function createPharFile($pharFilePath, $originalFile) {
    $originalFile = realpath($originalFile);

    try{
        $phar = new Phar($pharFilePath);
        $phar->addFile($originalFile);
        $phar->compressFiles( Phar::GZ );
        $phar->stopBuffering();
        $phar->setStub($phar-> createDefaultStub($pharFilePath));
        $phar->setStub("<?php Phar::mapPhar();
include 'phar://{$pharFilePath}/{$originalFile}'; __HALT_COMPILER(); ?>");

    }catch (Exception $e){
        var_dump($e->getMessage());
    }
}
?>

