FROM mysql:5.7
MAINTAINER yulinzhihou "yulinzhihou@gmail.com"
# 导入纯净天龙数据库
COPY ./initdb.d/*.sql /docker-entrypoint-initdb.d/
RUN  mysql -h 127.0.0.1 -uroot -p"${TL_MYSQL_PASSWORD}" -e "create database web if not exists; " && \
mysql -h 127.0.0.1 -uroot -p"${TL_MYSQL_PASSWORD}" web < /docker-entrypoint-initdb.d/web.sql

CMD ["mysqld"]
