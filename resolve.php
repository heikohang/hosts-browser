<?php
// Extract the hostname
$domain = parse_url($_GET["domain"]);
if(!empty($domain["host"])) {
	$host = $domain["host"];
} elseif(empty($host["host"]) && !empty($domain["path"])) {
	$host = $domain["path"];
}

$dns = $_GET["dns"];

$ip = shell_exec("dig a +short @".$dns." ".$host." | head -n1");
echo $ip;