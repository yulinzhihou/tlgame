#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-06-08
# comment: 一键端配置好，开机自动进游戏
echo "/bin/bash /usr/local/bin/swap >/dev/null 2>/dev/null" >> /etc/rc.local && echo "/bin/bash /usr/local/bin/runtlbb >/dev/null 2>/dev/null" >> /etc/rc.local && chmod +x /etc/rc.local