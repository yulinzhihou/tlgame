#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 查看服务器进程情况
if [ -n $1 ]; then
    cd ~/.tlgame/gs && docker-compose exec server top
else
    cd ~/.tlgame/gs && docker-compose exec $1 top
fi
