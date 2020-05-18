#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 根据env文件的环境变量，修改对应的配置文件，复制配置文件替换到指定目录，并给与相应权限
#\cp -rf /etc/gs_ini/*.ini /tlgame/tlbb/Server/Config && chmod -R 777 /tlgame && chown -R root:root /tlgame
if [ -n $TLBBDB_MYSQL_PASS ]; then
    tar zxf /.tlgame/gs/scripts/ini.tar.gz -C /tlgame/tlbb/Server/Config && chmod -R 777 /tlgame && chown -R root:root /tlgame
fi
