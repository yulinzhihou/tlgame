#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-27
# comment: 一键命令关闭所有
cd ~/.tlgame/gs && \
docker-compose restart

if [ $? == 0 ]; then
    echo -e "\e[44m 服务端已经重启成功，如果需要重新开服，请运行【runtlbb】命令\e[0m"
fi
