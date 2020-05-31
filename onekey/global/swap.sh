#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-23
# comment: 内存小，但是容量有20个G以上的云服务器。需要拓展虚拟内存
mkdir -p /usr/swap && dd if=/dev/zero of=/usr/swap/swapfile bs=100M count=40 && \
mkswap /usr/swap/swapfile && \
chmod -R 600 /usr/swap/swapfile && swapon /usr/swap/swapfile