#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-06-01
# comment: 连接服务器环境
if [ -n $1 ]; then
    cd ~/.tlgame/onekey && docker-compose exec server bash
elif [ $1 -eq 'php' ] || [ $1 -eq 'nginx' ]; then
    cd ~/.tlgame/onekey && docker-compose exec $1 sh
else
    cd ~/.tlgame/onekey && docker-compose exec $1 bash
fi