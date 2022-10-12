#!/bin/bash

echo 'upgrading server...'

apt update  -y
apt upgrade -y

echo 'finished upgrading server...'

echo 'installing packages...';

apt install apache2 -y
apt install unzip -y
apt install wget -y

echo 'finished installing packages...'

echo 'downloading app...';

cd  /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
unzip main.zip -d app
rm -f main.zip

echo 'finished downloading app...'

echo 'installing app...'

rm -rf /var/www/html/*
cd /tmp/app/linux-site-dio-main
cp -rf * /var/www/html
cd /tmp
rm -rf app

echo 'finished installing app...'

echo 'enabling apache on boot...'

systemctl enable apache2

echo 'finished enabling apache on boot...'

