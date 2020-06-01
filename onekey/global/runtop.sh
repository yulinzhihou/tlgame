#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-06-01
# comment: 查看服务器进程情况
if [[ -n $1 ]]; then
    cd ~/.tlgame/onekey && docker-compose top server
else
    cd ~/.tlgame/onekey && docker-compose top $1
fi
