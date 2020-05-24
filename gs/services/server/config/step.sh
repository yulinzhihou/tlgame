#!/usr/bin/env bash
STEP=$1
case $1 in
    'billing')
    cd /home/billing/ && ./billing &
   ;;
   'shm')
   cd /home/tlbb/Server && ./shm start
   ;;
   'login')
   cd /home/tlbb/Server && ./Login
   ;;
    'world')
    cd /home/tlbb/Server && ./World
   ;;
    'server')
    cd /home/tlbb/Server && ./Server
   ;;
    *)
    echo "你输入的参数有问题！！"
   ;;
esac