#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-006-01
# comment: 一键开服，适合于那种可以一键开启的服务端，如果3-5分钟后，服务端没开启，则需要使用分步开服方式
cd ~/.tlgame/onekey && docker-compose exec -d server /home/billing/billing \& && cd ~/.tlgame/onekey && docker-compose exec -d server /bin/bash run.sh