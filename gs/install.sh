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

# 获取系统位数，32 位，64 位
Get_OS_Bit()
{
    if [[ `getconf WORD_BIT` = '32' && `getconf LONG_BIT` = '64' ]] ; then
        Is_64bit='y'
    else
        Is_64bit='n'
    fi
}

# 获取平台名称
Get_Dist_Version()
{
    if command -v lsb_release >/dev/null 2>&1; then
        DISTRO_Version=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        DISTRO_Version="$DISTRIB_RELEASE"
    elif [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO_Version="$VERSION_ID"
    fi
    if [[ "${DISTRO}" = "" || "${DISTRO_Version}" = "" ]]; then
        if command -v python2 >/dev/null 2>&1; then
            DISTRO_Version=$(python2 -c 'import platform; print platform.linux_distribution()[1]')
        elif command -v python3 >/dev/null 2>&1; then
            DISTRO_Version=$(python3 -c 'import platform; print(platform.linux_distribution()[1])')
        else
            Install_LSB
            DISTRO_Version=`lsb_release -rs`
        fi
    fi
    printf -v "${DISTRO}_Version" '%s' "${DISTRO_Version}"
}

# 字体输出颜色
Color_Text()
{
  echo -e " \e[0;$2m$1\e[0m"
}

Echo_Red()
{
  echo $(Color_Text "$1" "31")
}

Echo_Green()
{
  echo $(Color_Text "$1" "32")
}

Echo_Yellow()
{
  echo $(Color_Text "$1" "33")
}

Echo_Blue()
{
  echo $(Color_Text "$1" "34")
}


# 设置服务器时间
Set_Timezone()
{
    Echo_Blue "Setting timezone..."
    rm -rf /etc/localtime
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
}

# 禁用selinux
Disable_Selinux()
{
    if [ -s /etc/selinux/config ]; then
        sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
    fi
}

# 获取系统安装包组件名称
Get_Dist_Name()
{
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux" /etc/issue || grep -Eq "Red Hat Enterprise Linux" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Amazon Linux" /etc/issue || grep -Eq "Amazon Linux" /etc/*-release; then
        DISTRO='Amazon'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    elif grep -Eqi "Deepin" /etc/issue || grep -Eq "Deepin" /etc/*-release; then
        DISTRO='Deepin'
        PM='apt'
    elif grep -Eqi "Mint" /etc/issue || grep -Eq "Mint" /etc/*-release; then
        DISTRO='Mint'
        PM='apt'
    elif grep -Eqi "Kali" /etc/issue || grep -Eq "Kali" /etc/*-release; then
        DISTRO='Kali'
        PM='apt'
    else
        DISTRO='unknow'
    fi
    Get_OS_Bit
}

# 获取红帽版本
Get_RHEL_Version()
{
    Get_Dist_Name
    if [ "${DISTRO}" = "RHEL" ]; then
        if grep -Eqi "release 5." /etc/redhat-release; then
            echo "Current Version: RHEL Ver 5"
            RHEL_Ver='5'
        elif grep -Eqi "release 6." /etc/redhat-release; then
            echo "Current Version: RHEL Ver 6"
            RHEL_Ver='6'
        elif grep -Eqi "release 7." /etc/redhat-release; then
            echo "Current Version: RHEL Ver 7"
            RHEL_Ver='7'
        elif grep -Eqi "release 8." /etc/redhat-release; then
            echo "Current Version: RHEL Ver 8"
            RHEL_Ver='8'
        fi
    fi
}

# 修改红帽系统仓库源
RHEL_Modify_Source()
{
    Get_RHEL_Version
    if [ "${RHELRepo}" = "local" ]; then
        echo "DO NOT change RHEL repository, use the repository you set."
    else
        echo "RHEL ${RHEL_Ver} will use aliyun centos repository..."
        wget --prefer-family=IPv4 http://mirrors.aliyun.com/repo/Centos-${RHEL_Ver}.repo -O /etc/yum.repos.d/Centos-${RHEL_Ver}.repo
        yum clean all
        yum makecache
    fi
    sed -i "s/^enabled[ ]*=[ ]*1/enabled=0/" /etc/yum/pluginconf.d/subscription-manager.conf
}


# 更新系统组件与安装必要的安装包
update_install_plugins() {
#    rm -f /var/run/yum.pid
#    mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup
#    mv /etc/yum.repos.d/epel-testing.repo /etc/yum.repos.d/epel-testing.repo.backup
#    wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
#    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
#    wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
#    yum makecache
    PLUGINS="dos2unix epel-release yum-utils wget git vim zip unzip zlib zlib-devel freetype freetype-devel lsof pcre pcre-devel crontabs"
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

# 启动环境
docker_run () {
    cd ~/.tlgame/gs && docker-compose up -d
}

#配置全局变量参数
set_global_var() {
    echo -e "export TL_MYSQL_PORT=`[ ! -z ${TL_MYSQL_PORT} ] && echo ${TL_MYSQL_PORT} || echo 33060`" >>  /tmp/gsconfig.txt
    echo -e "export LOGIN_PORT=`[ ! -z ${LOGIN_PORT} ] && echo ${LOGIN_PORT} || echo 13580`" >> /tmp/gsconfig.txt
    echo -e "export SERVER_PORT=`[ ! -z ${SERVER_PORT} ] && echo ${SERVER_PORT} || echo 15680`" >> /tmp/gsconfig.txt
    echo -e "export TL_MYSQL_PASSWORD=`[ ! -z ${TL_MYSQL_PASSWORD} ] && echo ${TL_MYSQL_PASSWORD} || echo 123456`" >> /tmp/gsconfig.txt
    echo -e "export WEBSERVER_PORT=`[ ! -z ${WEBSERVER_PORT} ] && echo ${WEBSERVER_PORT} || echo 58080`" >> /tmp/gsconfig.txt

    cat /tmp/gsconfig.txt > /etc/profile.d/gsconfig.sh && rm -rf /tmp/gsconfig.txt && \
    source /etc/profile.d/gsconfig.sh
}

# 关闭现有安装器
Kill_PM()
{
    if ps aux | grep -E "yum|dnf" | grep -qv "grep"; then
        kill -9 $(ps -ef|grep -E "yum|dnf"|grep -v grep|awk '{print $2}')
        if [ -s /var/run/yum.pid ]; then
            rm -f /var/run/yum.pid
        fi
    elif ps aux | grep -E "apt-get|dpkg|apt" | grep -qv "grep"; then
        kill -9 $(ps -ef|grep -E "apt-get|apt|dpkg"|grep -v grep|awk '{print $2}')
        if [[ -s /var/lib/dpkg/lock-frontend || -s /var/lib/dpkg/lock ]]; then
            rm -f /var/lib/dpkg/lock-frontend
            rm -f /var/lib/dpkg/lock
            dpkg --configure -a
        fi
    fi
}

# 更新时间
CentOS_InstallNTP()
{
    Echo_Blue "[+] Installing ntp..."
    yum install -y ntpdate
    ntpdate -u pool.ntp.org
    date
    start_time=$(date +%s)
}

# 移除系统自带的软件
CentOS_RemoveAMP()
{
    Echo_Blue "[-] Yum remove packages..."
    rpm -qa|grep httpd
    rpm -e httpd httpd-tools --nodeps
    if [[ "${DBSelect}" != "0" ]]; then
        yum -y remove mysql-server mysql mysql-libs mariadb-server mariadb mariadb-libs
        rpm -qa|grep mysql
        if [ $? -ne 0 ]; then
            rpm -e mysql mysql-libs --nodeps
            rpm -e mariadb mariadb-libs --nodeps
        fi
    fi
    rpm -qa|grep php
    rpm -e php-mysql php-cli php-gd php-common php --nodeps

    Remove_Error_Libcurl

    yum -y remove httpd*
    yum -y remove php*
    yum clean all
}
# 执行操作
Disable_Selinux
Set_Timezone
Get_Dist_Name
Get_Dist_Version
RHEL_Modify_Source
update_install_plugins
docker_ce
set_command
set_global_var
docker_run

clear
echo "====================================="
echo -e "\e[44m GS游享网 [https://gsgameshare.com] 专用环境安装成功!\e[0m"
echo -e "====================================="
echo -e "\t1.数据库端口: `[ ! -z ${TL_MYSQL_PORT} ] && echo ${TL_MYSQL_PORT} || echo  33061`"
echo -e "\t2.数据库密码: `[ ! -z ${TL_MYSQL_PASSWORD} ] && echo ${TL_MYSQL_PASSWORD} || echo 123456`"
echo -e "\t3.登录网关端口: `[ ! -z ${LOGIN_PORT} ] && echo ${LOGIN_PORT} || echo 13580`"
echo -e "\t4.游戏网关端口: `[ ! -z ${SERVER_PORT} ] && echo ${SERVER_PORT} || echo 15680`"
echo -e "\t5.网站端口: `[ ! -z ${WEBSERVER_PORT} ] && echo ${WEBSERVER_PORT} || echo 58080`"
echo -e "\e[44m 把域名解析到服务器IP上加网站端口，然后把网站文件上传到 /tlgame/www 目录里面即可访问。\e[0m"
echo -e "\e[44m 如：http://192.168.66.66:58080 遇到问题可以加群：826717146。\e[0m"
echo -e "====================================="
endTime=`date +%s`
((outTime=($endTime-$startTime)/60))
echo -e "总耗时:\e[44m $outTime \e[0m 分钟!"