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
    mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup
    mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup
    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
    yum makecache
    PLUGINS="dos2unix epel-release yum-utils wget git vim zip unzip"
    yum -y install ${PLUGINS}
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
    ls -l /root/.tlgame/onekey/global/ | awk '{print $9}' > ./command.txt
    for VAR  in `cat ./command.txt`; do
        if [ -n ${VAR} ]; then
            \cp -rf ~/.tlgame/onekey/global/${VAR} /usr/local/bin/${VAR%%.*} && chmod +x /usr/local/bin/${VAR%%.*}
        fi
    done
}

# 配置 github_user_content 安装源
#github_user_content(){
#    # 获取域名对应解析的IP地址
#    IP_STR=`ping raw.githubusercontent.com -c 1 | sed '1{s/[^(]*(//;s/).*//;q}'`
#    # 写入HOSTS文件
#    #if [[ -z `find /etc/hosts|xargs grep -ri "${IP_STR}"` ]]; then
#        sudo echo "${IP_STR}  raw.githubusercontent.com" >> /etc/hosts
#    #fi
#    echo "${IP_STR}  raw.githubusercontent.com"
#}
# 启动环境
docker_run () {
    cd ~/.tlgame/onekey && docker-compose up -d
}

#配置全局变量参数
set_global_var() {
    echo -e "export WEB_MYSQL_PORT=`[ ! -z ${WEB_MYSQL_PORT} ] && echo ${WEB_MYSQL_PORT} || echo 33060`" >> /etc/profile
    echo -e "export TLBB_MYSQL_PORT=`[ ! -z ${TLBB_MYSQL_PORT} ] && echo ${TLBB_MYSQL_PORT} || echo 33061`" >> /etc/profile
    echo -e "export LOGIN_PORT=`[ ! -z ${LOGIN_PORT} ] && echo ${LOGIN_PORT} || echo 13580`" >> /etc/profile
    echo -e "export SERVER_PORT=`[ ! -z ${SERVER_PORT} ] && echo ${SERVER_PORT} || echo 15680`" >> /etc/profile
    echo -e "export WEBDB_PASSWORD=`[ ! -z ${WEBDB_PASSWORD} ] && echo ${WEBDB_PASSWORD} || echo 123456`" >> /etc/profile
    echo -e "export TLBBDB_PASSWORD=`[ ! -z ${TLBBDB_PASSWORD} ] && echo ${TLBBDB_PASSWORD} || echo 123456`" >> /etc/profile
    echo -e "export BILLING_PORT=`[ ! -z ${BILLING_PORT} ] && echo ${BILLING_PORT} || echo 21818`" >> /etc/profile
}
# 执行操作
set_clock
update_install_plugins
docker_ce
set_command
docker_run

echo "====================================="
echo -e "\033[32m Tlgame 环境安装成功!\033[0m"
echo -e "====================================="
echo -e "账号数据库端口: `[ ! -z ${WEB_MYSQL_PORT} ] && echo ${WEB_MYSQL_PORT} || echo 33060`"
echo -e "游戏数据库端口: `[ ! -z ${TLBB_MYSQL_PORT} ] && echo ${TLBB_MYSQL_PORT} || echo 33061`"
echo -e "Billing端口: `[ ! -z ${BILLING_PORT} ] && echo ${BILLING_PORT} || echo 21818`"
echo -e "登录网关端口: `[ ! -z ${LOGIN_PORT} ] && echo ${LOGIN_PORT} || echo 13580`"
echo -e "游戏网关端口: `[ ! -z ${SERVER_PORT} ] && echo ${SERVER_PORT} || echo 15680`"
echo -e "账号数据库密码: `[ ! -z ${WEBDB_PASSWORD} ] && echo ${WEBDB_PASSWORD} || echo 123456`"
echo -e "游戏数据库密码: `[ ! -z ${TLBBDB_PASSWORD} ] && echo ${TLBBDB_PASSWORD} || echo 123456`"
echo -e "网站把域名解析到云服务器IP上，然后把网站文件放到 /tlgame/www/localhost 目录里面即可访问。"
echo -e "====================================="
endTime=`date +%s`
((outTime=($endTime-$startTime)/60))
echo -e "总耗时:\033[32m $outTime \033[0m 分钟!"