#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 服务器环境重构，删除容器，重新启动
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && rm -rf /tlgame/tlbb/* && cd ~/.tlgame/gs && docker-compose up -d
echo -e "\e[44m 环境已经重构成功，请上传服务端到指定位置，然后再开服操作！！ \e[0m"