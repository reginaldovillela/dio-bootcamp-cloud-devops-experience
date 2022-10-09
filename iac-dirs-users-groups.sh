#!/bin/bash

DEFAULT_PASSWD='Senha123'
DIR_PUB='publico'
DIR_ADM='adm'
DIR_VEN='ven'
DIR_SEC='sec'
GRP_ADM='GRP_ADM'
GRP_VEN='GRP_VEN'
GRP_SEC='GRP_SEC'

echo 'creating directories...'

mkdir /$DIR_PUB
mkdir /$DIR_ADM
mkdir /$DIR_VEN
mkdir /$DIR_SEC

echo 'finished creating directories...'

echo 'creating groups...'

groupadd $GRP_ADM
groupadd $GRP_VEN
groupadd $GRP_SEC

echo 'finished creating groups...'

echo 'changing permissions...'

chown root:$GRP_ADM /$DIR_ADM
chown root:$GRP_VEN /$DIR_VEN
chown root:$GRP_SEC /$DIR_SEC

chmod 777 /$DIR_PUB
chmod 770 /$DIR_ADM
chmod 770 /$DIR_VEN
chmod 770 /$DIR_SEC

echo 'finished changing permissions...'

echo 'creating users...'

useradd carlos -c 'Carlos da Silva' -m -s /bin/bash -p $(openssl passwd $DEFAULT_PASSWD) -G $GRP_ADM
useradd maria -c 'Maria da Silva' -m -s /bin/bash -p $(openssl passwd $DEFAULT_PASSWD) -G $GRP_ADM
useradd joao -c 'João da Silva' -m -s /bin/bash -p $(openssl passwd $DEFAULT_PASSWD) -G $GRP_ADM

useradd debora -c 'Débora da Silva' -m -s /bin/bash -p $(openssl passwd $DEFAULT_PASSWD) -G $GRP_VEN
useradd sebastiana -c 'Sebastiana da Silva' -m -s /bin/bash -p $(openssl passwd $DEFAULT_PASSWD) -G $GRP_VEN
useradd roberto -c 'Roberto da Silva' -m -s /bin/bash -p $(openssl passwd $DEFAULT_PASSWD) -G $GRP_VEN

useradd josefina -c 'Josefina da Silva' -m -s /bin/bash -p $(openssl passwd $DEFAULT_PASSWD) -G $GRP_SEC
useradd amanda -c 'Amanda da Silva' -m -s /bin/bash -p $(openssl passwd $DEFAULT_PASSWD) -G $GRP_SEC
useradd rogerio -c 'Rogerio da Silva' -m -s /bin/bash -p $(openssl passwd $DEFAULT_PASSWD) -G $GRP_SEC

echo 'finished creating users...'
