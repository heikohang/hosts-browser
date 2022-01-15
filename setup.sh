# Dependancy installer script for Hosts Browser
# 

sudo apt-get update

# PHP 8.1 & Ubuntu
# sudo apt install -y software-properties-common
# sudo add-apt-repository ppa:ondrej/php
# sudo apt update
# sudo apt install -y php8.1

# Ubuntu
# sudo apt-get install -y \
#     ca-certificates \
#     curl \
#     gnupg \
#     lsb-release
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# sudo apt upgrade -y

# Debian
# sudo apt-get install \
#     ca-certificates \
#     curl \
#     gnupg \
#     lsb-release
# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Installs Docker
OUTPUT=$(lsb_release -si)
if echo $OUTPUT | grep -q "Debian"
then
	OS="debian"
elif echo $OUTPUT | grep -q "Ubuntu"
then
	OS="ubuntu"
else
	echo "Not a Debian or Ubuntu OS"
	exit 1
fi

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/${OS}/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/${OS} \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get install -y php

# Pull Docker image
#docker build -t heikohang/alpine-xfce-vnc-firefox .
docker pull heikohang/alpine-xfce-vnc-firefox

echo "www-data ALL=NOPASSWD: /usr/bin/docker" >> /etc/sudoers
echo "www-data ALL=(ALL) NOPASSWD: /bin/bash */start_firefox.sh *" >> /etc/sudoers

# Cron jobs - set one up as required
# * * * * * docker ps --format="{{.RunningFor}} {{.Names}}"  | grep minutes | awk -F " " '{if ($1>9) print $4}' | xargs docker rm -f 
# * * * * * docker ps --format="{{.RunningFor}} {{.Names}}"  | grep minutes |  awk -F: '{if($1>10)print$1}' | awk ' {print $4} ' | xargs docker rm -f
# * * * * * docker ps --format="{{.RunningFor}} {{.Names}}"  | grep hours |  awk -F: '{if($1>2)print$1}' | awk ' {print $4} ' | xargs docker rm -f
# 0 * * * * docker ps -aq --no-trunc | xargs docker rm -f