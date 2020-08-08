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