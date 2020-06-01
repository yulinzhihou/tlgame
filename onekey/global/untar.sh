#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-06-01
# comment: 解压tar.gz文件包到指定的目录，并给相应的权限
if [ -f "/root/tlbb.tar.gz" ]; then
    rm -rf /root/tlbb && tar zxf ~/tlbb.tar.gz &&  rm -rf ~/tlbb.tar.gz
elif [ -f "/root/tlbb.zip" ]; then
    rm -rf /root/tlbb && unzip ~/tlbb.zip && rm -rf ~/tlbb.zip
else
    echo "服务端文件不存在，或者位置上传错误！"
fi