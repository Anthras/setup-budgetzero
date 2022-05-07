#!/bin/bash
sudo apt -y update && sudo apt -y upgrade
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable docker
sudo docker pull budgetzero/budgetzero:latest
sudo docker run -d -p 8080:8080 --name budgetzero budgetzero/budgetzero
sudo docker run -d -p 5984:5984 --name budgetzero-couchdb-sync -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=password couchdb:latest
echo "see https://github.com/budgetzero/budgetzero for remainder of couchdb setup"
