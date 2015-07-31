<?php
echo 'Password: ';
$pwd = preg_replace('/\r?\n$/', '', `stty -echo; head -n1 ; stty echo`);
echo "\n";
echo "Your password was: {$pwd}.\n";
?>
