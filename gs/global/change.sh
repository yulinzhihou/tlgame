#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-08-09
# comment: 换版本
docker stop $(docker ps -a -q) && \
docker rm $(docker ps -a -q) && \
rm -rf /tlgame/tlbb/* && \
untar && \
cd ~/.tlgame/gs && \
docker-compose up -d && \
setini && \
runtlbb
echo -e "\e[44m 换端成功，请耐心等待几分钟后，建议使用：【link】再使用【top】 查看运行情况，或者使用备用命令【runtop】先进行查看开服的情况！\e[0m"