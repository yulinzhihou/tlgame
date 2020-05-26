#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-26
# comment: 当用户需要重新生成数据库端口，密码时，则使用此命令进行重装写入配置，注意，执行完成后需要重启服务器再进行配置。否则需要使用 source /etc/profile 让数据临时生效
echo -e "export WEB_MYSQL_PORT=`[ ! -z ${WEB_MYSQL_PORT} ] && echo ${WEB_MYSQL_PORT} || echo 33060`" > /tmp/pass.txt
echo -e "export TLBB_MYSQL_PORT=`[ ! -z ${TLBB_MYSQL_PORT} ] && echo ${TLBB_MYSQL_PORT} || echo 33061`" >> /tmp/pass.txt
echo -e "export LOGIN_PORT=`[ ! -z ${LOGIN_PORT} ] && echo ${LOGIN_PORT} || echo 13580`" >> /tmp/pass.txt
echo -e "export SERVER_PORT=`[ ! -z ${SERVER_PORT} ] && echo ${SERVER_PORT} || echo 15680`" >> /tmp/pass.txt
echo -e "export WEBDB_PASSWORD=`[ ! -z ${WEBDB_PASSWORD} ] && echo ${WEBDB_PASSWORD} || echo 123456`" >> /tmp/pass.txt
echo -e "export TLBBDB_PASSWORD=`[ ! -z ${TLBBDB_PASSWORD} ] && echo ${TLBBDB_PASSWORD} || echo 123456`" >> /tmp/pass.txt

cat /tmp/pass.txt >> /etc/profile && rm -rf /tmp/pass.txt