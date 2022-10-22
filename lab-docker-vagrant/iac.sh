#!/bin/bash

TYPE=$1
IP=$2
IP_MASTER=$3

echo 'installing docker...'

sudo apt remove -y docker docker-engine docker.io containerd runc
sudo apt update -y
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo 'finished installing docker...'

if [ $TYPE = "MASTER" ]; then

    echo '### configuring master...'

    apt update -y
    apt install -y nfs-server unzip

    sudo mkdir -m 777 -p /data/docker
    sudo mkdir -m 777 -p /data/app

    echo 'creating shared directories...'

    echo "/data/docker *(rw,sync,subtree_check)" >>/etc/exports
    echo "/data/app *(rw,sync,subtree_check)" >>/etc/exports
    exportfs -ar

    echo 'finished creating shared directories...'

    echo 'creating cluster docker swarm...'

    docker swarm init --advertise-addr $IP
    echo "#!/bin/bash" >>/data/docker/swarm-join.sh
    docker swarm join-token worker | grep docker >>/data/docker/swarm-join.sh
    chmod +x /data/docker/swarm-join.sh

    echo 'finished creating cluster docker swarm...'

    echo 'downloading and installing app...'

    curl -fsSL https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -o /tmp/app.zip
    unzip /tmp/app.zip -d /tmp
    cp -rf /tmp/linux-site-dio-main/* /data/app
    rm -rf /tmp/app
    rm -f /tmp/app.zip

    docker service create --name app --replicas 10 -p 80:80 --mount type=bind,src=/data/app,dst=/usr/local/apache2/htdocs httpd

    echo 'finished downloading and installing app...'

    echo '### finished configuring master...'

else

    echo '### configuring node..'

    apt update -y
    apt install -y nfs-common

    sudo mkdir -m 777 -p /data/docker
    sudo mkdir -m 777 -p /data/app

    echo 'joing cluster docker swarm...'
    
    sudo mount $IP_MASTER:/data/app /data/app
    sudo mount $IP_MASTER:/data/docker /data/docker
    sudo sh /data/docker/swarm-join.sh

    echo 'finished joing cluster docker swarm...'

    echo '### finished configuring node...'

fi
