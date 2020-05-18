#!/usr/bin/env bash
# author: yulinzhihou
# mail: yulinzhihou@gmail.com
# date: 2020-05-17
# 项目地址：https://github.com/yulinzhihou/tlgame.git
# 项目地址：https://gitee.com/yulinzhihou/tlgame.git
# 如果觉得写得有点点用，请麻烦点个 star
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
cur_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
startTime=`date +%s`
# 设置服务器时间
set_clock(){
    yum -y install ntp
    \cp -a -r /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    echo 'Synchronizing system time..'
    ntpdate 0.asia.pool.ntp.org
    hwclock -w
}

# 更新系统组件与安装必要的安装包
update_install_plugins() {
    rm -f /var/run/yum.pid
    PLUGINS="epel-release yum-utils device-mapper-persistent-data lvm2 wget git vim python-devel python-imaging zip unzip openssl openssl-devel gcc libxml2 libxml2-dev libxslt* zlib zlib-devel libjpeg-devel libpng-devel libwebp libwebp-devel freetype freetype-devel lsof pcre pcre-devel vixie-cron crontabs"
    yum -y install ${PLUGINS} && yum -y update
}

# 配置与安装Docker-ce
docker_ce() {
    sudo yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    sudo yum makecache fast && sudo yum -y install docker-ce docker-compose && systemctl enable docker && sudo systemctl start docker
    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://f0tv1cst.mirror.aliyuncs.com"]
}
EOF
    sudo systemctl daemon-reload && sudo systemctl restart docker
}

# 配置常用命令到系统中
set_command() {
    ls -l /root/.tlgame/gs/global/ | awk '{print $9}' > ./command.txt
    for VAR  in `cat ./command.txt`; do
        if [ -n ${VAR} ]; then
            \cp -rf ~/.tlgame/gs/global/${VAR} /usr/local/bin/${VAR%%.*} && chmod +x /usr/local/bin/${VAR%%.*}
        fi
    done
}

# 执行操作
set_clock
update_install_plugins
docker_ce
set_command

echo "====================================="
echo -e "\033[32mThe install successful!\033[0m"
echo -e "====================================="
echo -e "网站目录: /tlgame/www/localhost"
echo -e "账号数据库端口: 33060"
echo -e "游戏数据库端口: 33061"
echo -e "登录网关端口: 13580"
echo -e "游戏网关端口: 15680"
echo -e "账号数据库密码: 123456"
echo -e "游戏数据库密码: 123456"
echo -e "====================================="
endTime=`date +%s`
((outTime=($endTime-$startTime)/60))
echo -e "Time consuming:\033[32m $outTime \033[0mMinute!"