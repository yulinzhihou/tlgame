## 论坛一键端服务器架设环境开服食用指南

## 以下是手动配置云服务器环境详细配置手册
- 第一步：下载部署环境的项目，使用 `root` 用户登录。否则可能会出现报错

```bash
yum install -y wget git vim && \
cd ~ && git clone https://gitee.com/yulinzhihou/tlgame.git .tlgame
```

- 第二步：下载完之后项目，进入相应目录。(**注：如果需要配置参数，请在下面命令执行前，修改好 `env_example` ,具体修改方法，自行百度，方法很多，不会的单独出视频教程，否则使用默认**)

```bash
\cp -rf ~/.tlgame/onekey/env-example ~/.tlgame/onekey/.env
```

- 第三步：进行 `install.sh` 脚本安装环境，**（注：在运行安装命令前，必须确认你需要改的端口，密码都改了。不然一旦安装完成，再改就不会生效了）**

```bash
source ~/.tlgame/onekey/scripts/envfile.sh && \
bash ~/.tlgame/onekey/install.sh
```

- 第四步：如果小服务器配置，如`1G` `2G` 内存的，需要拓展一下虚拟内存，才能流畅跑起服务端**(注：此步骤超过4G内存的服务器可以不用管，必须保证服务器硬盘总容量有20G以上才能使用。不是空余空间，是总共有20G以上的就可以使用)**，如果内存大于或者等于**4G** 可以不需要执行下面的命令。

```bash
swap
```

- 第五步：上传服务端到 `/root` 下，点击 `xshell` 软件的 `sftp` 按钮，进行 `sftp` 命令行传输模式**（注：用 `winscp` 软件或者其他上传软件都行，只要把服务端上传到 `/root` 目录下即可，服务端的名称只能是  `tlbb.tar.gz` 或者 `tlbb.zip` 否则后面的操作会报错）**

```bash
untar && sed -i 's/exit$/sleep 99999999/g' /root/tlbb/run.sh && docker cp -L /root/tlbb onekey_server_1:/home
```

```bash
mkdir -p /root/ini && cd ~/.tlgame/onekey/scripts && tar zxf ini.tar.gz -C /root/ini && cd ~/ini && docker cp -L LoginInfo.ini onekey_server_1:/home/tlbb/Server/Config && docker cp -L ServerInfo.ini onekey_server_1:/home/tlbb/Server/Config && docker cp -L ShareMemInfo.ini onekey_server_1:/home/tlbb/Server/Config
```

```bash
mkdir -p /root/billing &&  cd ~/.tlgame/onekey/scripts && tar zxf billing.tar.gz -C /root/billing && docker cp -L /root/billing onekey_server_1:/home
```

```bash
#以上三条命令整合成两条命令
untar
setini
```
- 启动虚拟机开机自动启动虚拟机

```bash
echo "/bin/bash /usr/local/bin/swap >/dev/null 2>/dev/null" >> /etc/rc.local && 
echo "/bin/bash /usr/local/bin/runtlbb >/dev/null 2>/dev/null" >> /etc/rc.local && chmod +x /etc/rc.local
```