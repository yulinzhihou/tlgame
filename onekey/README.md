## 全新论坛一键端服务器架设环境开服食用指南

## 以下是手动配置云服务器环境详细配置手册
- 第一步：下载部署环境的项目，使用 `root` 用户登录。否则可能会出现报错

```bash
yum install -y wget git vim && \
cd ~ && git clone https://gitee.com/yulinzhihou/tlgame.git .tlgame
```

- 第二步：下载完之后项目，进入相应目录。(**注：如果需要配置参数，请在下面命令执行前，修改好 `env_example` ,具体修改方法，自行百度，方法很多，不会的单独出视频教程，否则使用默认**)

```bash
\cp -rf ~/.tlgame/gs/env-example ~/.tlgame/gs/.env
```

- 第三步：进行 `install.sh` 脚本安装环境，**（注：在运行安装命令前，必须确认你需要改的端口，密码都改了。不然一旦安装完成，再改就不会生效了）**

```bash
source ~/.tlgame/gs/scripts/envfile.sh && \
bash ~/.tlgame/gs/install.sh
```

- 第四步：如果小服务器配置，如`1G` `2G` 内存的，需要拓展一下虚拟内存，才能流畅跑起服务端**(注：此步骤超过4G内存的服务器可以不用管，必须保证服务器硬盘总容量有20G以上才能使用。不是空余空间，是总共有20G以上的就可以使用)**，如果内存大于或者等于**4G** 可以不需要执行下面的命令。

```bash
swap
```

- 第五步：上传服务端到 `/root` 下，点击 `xshell` 软件的 `sftp` 按钮，进行 `sftp` 命令行传输模式**（注：用 `winscp` 软件或者其他上传软件都行，只要把服务端上传到 `/root` 目录下即可，服务端的名称只能是  `tlbb.tar.gz` 或者 `tlbb.zip` 否则后面的操作会报错）**

```bash
cd ~
```

```BASH
put
```

```bash
docker cp -L /root/tlbb gs_server_1:/home

docker cp -L /root/billing gs_server_1:/home

docker cp -L /root/ini/* gs_server_1:/home/tlbb/Server/Config
```



- 第六步：解压上传的服务端 **（不需要考虑是哪种格式，使用此命令即可完成解压操作）**

```bash
untar
```

- 第七步：设置配置文件**（将配置文件进行覆盖，此配置文件会按照 `env-example` 文件里面定义的进行替换，没有更改的话则使用默认值）**

```bash
setini
```

- 第八步：开启服务端，等待结果
  

```bash
runtlbb
```

- 使用命令查看服务端运行状态

```bash
runtop
```

- 删除当前环境与游戏。（用于换端）

```bash
rebuild
```

- 删除所有数据与镜像文件（配置文件需要重新配置，重新安装环境）

```bash
remove
```

- **分步调试命令，总共需要创建5个 `SSH` 标签页，然后查看哪个窗口页面里面报错，再进行修改和调试配置** 

克隆 `ssh` 窗口标签页面

```bash
link
```

```bash
cd /home/billing && ./billing &
```

克隆 `ssh` 窗口标签页面

```bash
link
```

```bash 
cd /home/tlbb/Server && ./shm start
```

克隆 `ssh` 窗口标签页面

```bash
link
```

```bash
cd /home/tlbb/Server && ./Login
```

克隆 `ssh` 窗口标签页面

```bash
link
```

```bash
cd /home/tlbb/Server && ./World
```

克隆 `ssh` 窗口标签页面

```bash
link
```

```bash
cd /home/tlbb/Server && ./Server
```

- 增加环境可以更改端口，密码等，用于换端命令（前提是先执行 `rebuild` 再修改 `env-example` 再执行下面命令），执行完后建议重启服务器。

```bash
cd ~/.tlgame/gs && cp env-example .env && \
source ~/.tlgame/gs/scripts/envfile.sh  && \
resetini
```