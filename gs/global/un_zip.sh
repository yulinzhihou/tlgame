#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 解压zip文件包到指定的目录，并给相应的权限
if [ -f "/root/tlbb.tar.gz" ]; then
    rm -rf /tlgame/tlbb && tar zxf ~/tlbb.tar.gz -C /tlgame && chown -R root:root /tlgame && chmod -R 777 /tlgame && rm -rf ~/tlbb.tar.gz
elif [ -f "/root/tlbb.zip" ]; then
    rm -rf /tlgame/tlbb && sudo yum -y install unzip && unzip ~/tlbb.zip -d /tlgame && chmod -R 777 /tlgame && rm -rf ~/tlbb.zip
else
    echo "服务端文件不存在，或者位置上传错误！"
fi