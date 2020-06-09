#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-06-08
# comment: 配置一键端配置命令
sed -i 's/exit$/sleep 99999999/g' /root/tlbb/run.sh && docker cp -L /root/tlbb onekey_server_1:/home && mkdir -p /root/ini && cd ~/.tlgame/onekey/scripts && tar zxf ini.tar.gz -C /root/ini && cd ~/ini && docker cp -L LoginInfo.ini onekey_server_1:/home/tlbb/Server/Config && docker cp -L ServerInfo.ini onekey_server_1:/home/tlbb/Server/Config && docker cp -L ShareMemInfo.ini onekey_server_1:/home/tlbb/Server/Config && mkdir -p /root/billing &&  cd ~/.tlgame/onekey/scripts && tar zxf billing.tar.gz -C /root/billing && docker cp -L /root/billing onekey_server_1:/home && cd ~ && rm -rf *
