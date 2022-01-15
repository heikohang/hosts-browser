#!/bin/bash
# Attempts to launch a new Firefox window with the specified URL

port=$1
domain=$2

sleep 2

for try in {1..30}
do
    docker=`sudo docker exec firefox_${port} ps aux | grep "Xvnc"`
    if [[ -z "$docker" ]]
    then
        echo "NOT FOUND"
    else
        echo "FOUND"
        sleep 2
        sudo docker exec -d firefox_${port} chromium-browser --ignore-certificate-errors ${domain}
        break
    fi
sleep 1
done