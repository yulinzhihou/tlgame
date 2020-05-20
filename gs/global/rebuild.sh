#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 服务器环境重构，删除容器，重新启动
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && rm -rf /tlgame/tlbb && cd ~/.tlgame/gs && docker-compose up -d