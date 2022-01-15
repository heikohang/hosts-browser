#!/bin/bash
# Attempts to launch a new Firefox window with the specified URL

port=$1
domain=$2

sleep 2

for try in {1..30}
do
    docker=`sudo docker exec firefox_${port} ps aux | grep "xfdesktop"`
    if [[ -z "$docker" ]]
    then
        echo "NOT FOUND"
    else
        echo "FOUND"
        sleep 2
        sudo docker exec -d firefox_${port} firefox ${domain}
        # sudo xdotool search --name ".*Mozilla Firefox" windowsize 1920 1080
        break
    fi
    sleep 1
done