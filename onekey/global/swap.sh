#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-06-01
# comment: 内存小，但是容量有20个G以上的云服务器。需要拓展虚拟内存
if [ ! -f /usr/swap/swapfile ]; then
    mkdir -p /usr/swap && dd if=/dev/zero of=/usr/swap/swapfile bs=100M count=40 && \
    mkswap /usr/swap/swapfile && \
    chmod -R 600 /usr/swap/swapfile && swapon /usr/swap/swapfile && \
    echo "/usr/swap/swapfile swap swap defaults 0 0" >> /etc/fstab
    echo -e "\033[32m your swap was upto (`free -hm | awk -F " " 'NR==2{print $2}'` + 4.0G) success \033[0m"
else
    echo -e "\033[32m your swap was (`free -hm | awk -F " " 'NR==3{print $2}'`) \033[0m"
fi