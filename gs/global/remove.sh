#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 删除所有数据
docker stop $(docker ps -a -q) && \
docker rm $(docker ps -a -q) && \
docker rmi $(docker images -q) && \
mv /tlgame  /tlgame-`date +%Y%m%d%H%I%S` && \
rm -rf ~/.tlgame
echo -e "\e[44m 数据清除成功，请重新安排文档教程命令第一步开始安装环境！！！ \e[0m"