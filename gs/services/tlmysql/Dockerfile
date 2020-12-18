FROM mysql:5.7
#ARG TL_MYSQL_PASSWORD
MAINTAINER yulinzhihou "yulinzhihou@gmail.com"
# 导入纯净天龙数据库
COPY ./initdb.d/*.sql /docker-entrypoint-initdb.d/
COPY ./config/* /tmp/
RUN chmod a+x /tmp/create.sh
#RUN "${mysql[@]}" -uroot -p"${TL_MYSQL_PASSWORD}" -e "create database web; "
#RUN "${mysql[@]}" -uroot -p"${TL_MYSQL_PASSWORD}" web < /docker-entrypoint-initdb.d/web.sql
#
CMD ["mysqld"]
