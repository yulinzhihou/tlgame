FROM registry.cn-hangzhou.aliyuncs.com/yulinzhihou/gs_tlmysql:v0.1
MAINTAINER yulinzhihou "yulinzhihou@gmail.com"
COPY ./initdb.d/*.sql /docker-entrypoint-initdb.d/
COPY ./config/* /tmp/
RUN chmod a+x /tmp/create.sh
CMD ["mysqld"]
