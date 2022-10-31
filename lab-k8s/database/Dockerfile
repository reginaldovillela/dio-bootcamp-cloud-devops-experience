FROM mysql:5.7

WORKDIR /var/lib/mysql/

ENV MYSQL_ROOT_PASSWORD=MySql@123
ENV MYSQL_DATABASE=meubanco

ADD ddl-mensagens.sql /docker-entrypoint-initdb.d

EXPOSE 3306
