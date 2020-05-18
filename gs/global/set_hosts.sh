#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 服务器安装PHP插件
if [[ $# -lt 1 ]]; then
 echo $0 need a parameter
 exit 0
fi

ADDR=$1
# 获取域名对应解析的IP地址
IP_STR=`ping ${ADDR} -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
# 写入HOSTS文件
#if [[ -z `find /etc/hosts|xargs grep -ri "${IP_STR}"` ]]; then
    sudo echo "${IP_STR}  $1" >> /etc/hosts
#fi
echo "${IP_STR}  $1"
