FROM mysql:5.7
MAINTAINER yulinzhihou "yulinzhihou@gmail.com"

# 导入纯净天龙数据库
COPY ./initdb.d/*.sql /docker-entrypoint-initdb.d/

CMD ["mysqld"]