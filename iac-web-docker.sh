#!/bin/bash

DIR_EXEC=$(pwd)
DIR_APP='/data/app-web-docker'
DIR_DB='/data/db-web-docker'
mkdir $DIR_APP
chmod 777 $DIR_APP
mkdir $DIR_DB
chmod 777 $DIR_DB
cd ~

echo 'installing docker...'

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh

echo 'finished installer docker ...'

echo 'installing tools...'

apt update
apt install -y tar docker-compose docker-compose-plugin

echo 'finished installing tools...'

echo 'dowloading app...'

curl -fsSL https://br.wordpress.org/latest-pt_BR.tar.gz -o wordpress.tar.gz
tar -xvf wordpress.tar.gz -C $DIR_APP --strip-components=1
rm -f wordpress.tar.gz

echo 'finished downloading app...'

echo 'up app...'

cd $DIR_EXEC/app-web-docker
docker-compose up -d

echo 'finished up app...'
