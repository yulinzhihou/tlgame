#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 解压tar.gz文件包到指定的目录，并给相应的权限
if [ -f "/root/tlbb.tar.gz" ]; then
    rm -rf /tlgame/tlbb && tar zxf ~/tlbb.tar.gz -C /tlgame && chown -R root:root /tlgame && chmod -R 777 /tlgame && rm -rf ~/tlbb.tar.gz
    echo -e "\e[44m 服务端文件【tlbb.tar.gz】已经上传成功！！\e[0m"
elif [ -f "/root/tlbb.zip" ]; then
    rm -rf /tlgame/tlbb && sudo yum -y install unzip && unzip ~/tlbb.zip -d /tlgame && chmod -R 777 /tlgame && rm -rf ~/tlbb.zip
    echo -e "\e[44m 服务端文件 tlbb.zip 已经上传成功！！\e[0m"
else
    echo -e "\e[44m 服务端文件不存在，或者位置上传错误！\e[0m"
fi