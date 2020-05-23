#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 根据env文件的环境变量，修改对应的配置文件，复制配置文件替换到指定目录，并给与相应权限
#\cp -rf /etc/gs_ini/*.ini /tlgame/tlbb/Server/Config && chmod -R 777 /tlgame && chown -R root:root /tlgame
#tar zxf /.tlgame/gs/scripts/ini.tar.gz -C /tlgame/tlbb/Server/Config && chmod -R 777 /tlgame && chown -R root:root /tlgame
#
cd ~/.tlgame/gs && export $(grep -v '^#' /root/.tlgame/gs/.env | xargs -d '\n')
tar zxf /root/.tlgame/gs/scripts/ini.tar.gz -C /root/.tlgame/gs/scripts/
tar zxf /root/.tlgame/gs/scripts/billing.tar.gz -C /root/.tlgame/gs/scripts/
if [ ! -d "/tlgame/billing/" ]; then
    mkdir -p /tlgame/billing/
fi
tar zxf /root/.tlgame/gs/scripts/billing.tar.gz -C /tlgame/billing/

# 游戏配置文件
if [ ! $TLBBDB_PASSWORD -a $TLBBDB_PASSWORD -ne 123456 ]; then
    sed -i "s/DBPassword=123456/DBPassword=${TLBBDB_PASSWORD}/g" /root/.tlgame/gs/scripts/LoginInfo.ini
    sed -i "s/DBPassword=123456/DBPassword=${TLBBDB_PASSWORD}/g" /root/.tlgame/gs/scripts/ShareMemInfo.ini
    sed -i "s/123456/${TLBBDB_PASSWORD}/g" /root/.tlgame/gs/services/server/config/odbc.ini
fi

if [ ! $WEBDB_PASSWORD -a $WEBDB_PASSWORD -ne 123456 ]; then
    sed -i "s/123456/${WEBDB_PASSWORD}/g" /root/.tlgame/gs/scripts/config.json

fi

if [ ! $TLBB_MYSQL_PORT -a $TLBB_MYSQL_PORT -ne 3306 ]; then
    sed -i "s/DBPort=3306/DBPort=${TLBB_MYSQL_PORT}/g" /root/.tlgame/gs/scripts/LoginInfo.ini
    sed -i "s/DBPort=3306/DBPort=${TLBB_MYSQL_PORT}/g" /root/.tlgame/gs/scripts/ShareMemInfo.ini
    sed -i "s/3306/${TLBB_MYSQL_PORT}/g" /root/.tlgame/gs/services/server/config/odbc.ini
fi

if [ ! $WEB_MYSQL_PORT -a $WEB_MYSQL_PORT -ne 3306 ]; then
    sed -i "s/3306/${WEB_MYSQL_PORT}/g" /root/.tlgame/gs/scripts/config.json
fi

if [ ! $LOGIN_PORT -a $LOGIN_PORT -ne 13580 ]; then
    sed -i "s/Port0=13580/Port0=${LOGIN_PORT}/g" /root/.tlgame/gs/scripts/ServerInfo.ini
fi

if [ ! $SERVER_PORT -a $SERVER_PORT -ne 15680 ]; then
    sed -i "s/Port0=15680/Port0=${SERVER_PORT}/g" /root/.tlgame/gs/scripts/ServerInfo.ini
fi

#复制到已经修改好的文件到指定容器
\cp -rf /root/.tlgame/gs/scripts/*.ini /tlgame/tlbb/Server/Config/
\cp -rf /root/.tlgame/gs/scripts/config.json /tlgame/billing/
docker cp /root/.tlgame/gs/services/server/config/odbc.ini gs_server_1:/etc
#每次更新后，先重置更改过的文件
cd ~/.tlgame/ && \
git checkout -- gs/services/server/config/odbc.ini && \
rm -rf  /root/.tlgame/gs/scripts/*.ini && \
rm -rf  /root/.tlgame/gs/scripts/config.json