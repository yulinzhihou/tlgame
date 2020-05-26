## 全新手工架设环境开服食用指南

### 告别虚拟机开服🎉，告别win机装虚拟机开服🎉，告别win机+Linux机开服🎉。没错你没听错🎉，只需要一个Linux机就可以开服。市面上最小开服的配置机器即可开服🎉。技术交流群：826717146

## 以下是手动配置云服务器环境详细配置手册

- 暂时只支持云服务器 `CentOS 7.0` 及以上版本的**64**位系统。实测 **`1H2G1M`** 可以正常使用
- 本教程支持各种云服务器，只要能装 `CentOS7.0` 及以上**64**位系统即可
- 增加敏感配置项可以自定义，简单方便。如：数据库密码，端口等
- 集成分步调试开服的命令，可以更好的排错
- 本操作手册仅供学习使用，请勿用于商业用途，如有侵权，请与本人联系！
- 购买某云服务器，也可以使用本人的优惠券，[腾讯云](https://url.cn/gWNWl5N8)， [阿里云](https://www.aliyun.com/minisite/goods?userCode=buoewrk0) , 算是对我的一个支持
- 同时你觉得好用，请帮忙转发，让更多人看可以学习到技术

### 一、前期准备

- 购买服务器安装系统这里就不演示了，记住装 **`CentOS 7.0`** 以上的系统，不需要安装加装任何环境
- 安装好 `CentOS7` 最新版本**64**位系统
- 关闭防火墙，默认需要在安全组开放指定端口 **`33060` `33061` `13580` `15680`** , 或者全部开放也可以。
- 如果想自己定义相应端口，则需要自己去开放对应的安全组端口号

### 二、安装步骤（服务端）

- 第一步：下载部署环境的项目，使用 `root` 用户登录。否则可能会出现报错

```bash
yum install -y wget git vim && \
cd ~ && git clone https://gitee.com/yulinzhihou/tlgame.git .tlgame
```

- 第二步：下载完之后项目，进入相应目录。(**注：如果需要配置参数，请在下面命令执行前，修改好 `env_example` ,具体修改方法，自行百度，方法很多，不会的单独出视频教程，否则使用默认**)

```bash
cd ~/.tlgame/gs && cp env-example .env
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



### 三、安装步骤（客户端）

- 安装最新官方[客户端](http://tl.changyou.com/download/index.shtml) ,或者下载指定版本的[客户端](http://shang.qq.com/wpa/qunwpa?idkey=a67f7a7ee8d6fb3266b945d1ec512f31a374dcb74c863ead2d73029f5050576f) （进技术交流群获取）

- 解压补丁包
- 更新补丁，
- 配置单机测试使用的登录器
- 联网登录器。

### 四、网站配置（服务端）

- 准备白嫖的网站原版，有能力的自己写，或者改其他人的模板。这里就不一一演示了
- 将文件上传到 **`/tlgame/www/localhost`**  这个目录下面