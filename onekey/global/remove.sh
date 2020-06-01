#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-06-01
# comment: 删除所有数据
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker rmi $(docker images -q) && rm -rf /tlgame && rm -rf ~/.tlgame