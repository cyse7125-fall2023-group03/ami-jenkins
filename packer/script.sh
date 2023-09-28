#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install --fix-missing
sudo apt-get install default-jre -y
sudo java --version 

#install jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

#Install caddy
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https -y
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt-get update


sudo apt-get install caddy -y

sudo chmod 646 /etc/caddy/Caddyfile
cat <<EOF >> /etc/caddy/Caddyfile
jenkins.ganeshvasa.me, jenkins.banishmg.me, jenkins.udaykk.me {
    reverse_proxy localhost:8080
}
EOF

sudo systemctl start jenkins.service
sudo systemctl enable --now caddy

sudo systemctl status jenkins.service

