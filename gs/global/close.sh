#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-27
# comment: 一键命令关闭所有
cd ~/.tlgame/gs && \
docker-compose exec -d server /bin/bash stop.sh