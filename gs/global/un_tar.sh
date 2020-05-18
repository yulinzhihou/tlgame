#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# comment: 解压tar.gz文件包到指定的目录，并给相应的权限
rm -rf /tlgame/tlbb && tar zxf ~/tlbb.tar.gz -C /tlgame && chown -R root:root /tlgame && chmod -R 777 /tlgame && rm -rf ~/tlbb.tar.gz