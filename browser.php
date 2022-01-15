<?php
if(!isset($_POST["domain"])) die();

// Extract the hostname
$domain = parse_url($_POST["domain"]);
if(!empty($domain["host"])) {
	$host = $domain["host"];
} elseif(empty($host["host"]) && !empty($domain["path"])) {
	$host = $domain["path"];
}

$ip	= $_POST["ip"];
$port = rand(6000, 7000);
// $hash = bin2hex(mcrypt_create_iv(22, MCRYPT_DEV_URANDOM));
$hash = md5($port);

// Launch Docker and Firefox
// https://stackoverflow.com/a/539030/192126
$docker = system("sudo docker run --rm --name firefox_".$port." -d -p ".$port.":6080 --add-host ".$host.":".$ip." --add-host www.".$host.":".$ip." heikohang/alpine-xfce-vnc-firefox ");
sleep(5);
exec("sudo /bin/bash ".getcwd()."/start_firefox.sh ".$port." ".$host." &");
header("Location: http://".$_SERVER["SERVER_NAME"].":".$port."/?autoconnect=true");
