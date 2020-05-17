## 全新手工架设环境开服食用指南

### 告别虚拟机开服🎉，告别win机装虚拟机开服🎉，告别win机+Linux机开服🎉。没错你没听错🎉，只需要一个Linux机就可以开服。市面上最小开服的配置机器即可开服🎉。

### 唯一群号：826717146，或者访问我的[博客](https://gsgameshare.com)

- #### 第一步：服务端配置，虚拟机开机，使用`xshell` 软件连接进虚拟机系统

```SHELl
# step 1：上传服务端tlbb.tar.gz或者tlbb.zip
put
# step 1：解压到指定目录/TLsf/workspace
cd ~ && tar zxf tlbb.tar.gz -C /TLsf/workspace && chmod -R 777 /TLsf/workspace
# 备用step1: 如果是zip格式才执行下面命令
sudo yum -y install unzip && unzip tlbb.zip -d /TLsf/workspace && chmod -R 777

# step 2: 复制配置文件到服务端里面替换，LoginInfo.ini ServerInfo.ini ShareMemInfo.ini
cd ~/tlsf/aliyun/scripts && ./modify_ini_config.sh
```

- ### 第二步：正常一键开服

```shell
# step 1 : 开启验证
cd ~/tlsf/aliyun/scripts && ./ssh-server.sh

# 与step 1命令分开复制，等上面一条命令执行完成后再复制下面一条指令
cd ../billing && ./billing &

# step 2 : 开服,在复制命令前，需要新复制一个ssh窗口出来。
cd ~/tlsf/aliyun/scripts && ./ssh-server.sh
# 与step 2命令分开复制，等上面一条命令执行完成后再复制下面一条指令
./run.sh

# 以上命令执行完成,以上开服命令只针对一次性可以开服的端，对于残端不确定的端，需要使用备用开服方案

# step 3: 查看是否开服成功。
# 打开终端窗口，需要新复制一个ssh窗口出来。
cd ~/tlsf/aliyun/scripts && ./ssh-server.sh
# 与上面命令分开复制，等上面一条命令执行完成后再复制下面一条指令
top

# 查看有如下进程，表示开服成功
top - 14:10:18 up 44 min,  0 users,  load average: 0.36, 0.29, 0.13
Tasks:  11 total,   1 running,  10 sleeping,   0 stopped,   0 zombie
Cpu(s):  7.0%us,  3.2%sy,  0.0%ni, 89.7%id,  0.0%wa,  0.0%hi,  0.1%si,  0.0%st

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                     👌 93 root      20   0 2719m 2.0g  48m S 47.3 25.1   2:16.55 Server                  
👌 90 root      20   0  725m 360m 3276 S 23.0  4.5   0:39.32 Login                       
👌 88 root      20   0  592m 523m  94m S  5.0  6.6   0:10.82 World                       
👌 85 root      20   0  459m 331m 209m S  0.3  4.2   0:01.94 ShareMemory                 
    1 root      20   0  4152  328  252 S  0.0  0.0   0:00.05 tail                       
   31 root      20   0 11492 1748 1392 S  0.0  0.0   0:00.04 bash                       
   42 root      20   0 11492  776  416 S  0.0  0.0   0:00.00 bash                       👌 43 root      20   0  437m  10m 2312 S  0.0  0.1   0:00.02 billing                     
   53 root      20   0 11492 1748 1388 S  0.0  0.0   0:00.03 bash                       
  138 root      20   0 11492 1668 1348 S  0.0  0.0   0:00.15 bash                       
  149 root      20   0 14940 1128  904 R  0.0  0.0   0:00.08 top    
```

- ### 备用开服方案

```shell
# 备用开服方案：如果不确定服务端是否为完整无错的端，可以使用如下方式开服。此方式可以看到具体在运行哪块报错
# 打开窗口1，在复制命令前，需要新复制一个ssh窗口出来。link.sh
cd ~/tlsf/aliyun/scripts && ./ssh-server.sh 
# 与上面命令分开复制，等上面一条命令执行完成后再复制下面一条指令 billing.sh
cd ../billing && ./billing &

# 打开窗口2，在复制命令前，需要新复制一个ssh窗口出来。link.sh
cd ~/tlsf/aliyun/scripts && ./ssh-server.sh
# 与上面命令分开复制，等上面一条命令执行完成后再复制下面一条指令 shm.sh
cd Server && ./shm start

# 打开窗口3，在复制命令前，需要新复制一个ssh窗口出来。 link.sh
cd ~/tlsf/aliyun/scripts && ./ssh-server.sh
# 与上面命令分开复制，等上面一条命令执行完成后再复制下面一条指令 login.sh
cd Server && ./Login

# 打开窗口4，在复制命令前，需要新复制一个ssh窗口出来。 link.sh
cd ~/tlsf/aliyun/scripts && ./ssh-server.sh
# 与上面命令分开复制，等上面一条命令执行完成后再复制下面一条指令 world.sh
cd Server && ./World

# 打开窗口5，在复制命令前，需要新复制一个ssh窗口出来。 link.sh
cd ~/tlsf/aliyun/scripts && ./ssh-server.sh
# 与上面命令分开复制，等上面一条命令执行完成后再复制下面一条指令 server.sh
cd Server && ./Server

### 到此处，不管是完整服务端还是残端，已经执行完成开服所有命令，如果开服不成功，则查看对应的报错进行修复

# step 3: 查看是否开服成功。
# 打开终端窗口，需要新复制一个ssh窗口出来。
cd ~/tlsf/aliyun/scripts && ./ssh-server.sh
# 与上面命令分开复制，等上面一条命令执行完成后再复制下面一条指令
top
# 运行结果如上面所示
```



- #### 第三步：清空数据操作

```shell
# step 1 : 关闭并且删除容器
docker stop aliyun_server_1 && docker rm aliyun_server_1 && docker stop aliyun_webdb_1 && docker rm aliyun_webdb_1 && docker stop aliyun_tlbbdb_1 && docker rm aliyun_tlbbdb_1 && rm -rf /TLsf/workspace/tlbb
```



- ### 第四步：换端命令

```shell
# step 1 : 关闭并且删除旧容器 remove.sh
docker stop aliyun_server_1 && docker rm aliyun_server_1 && docker stop aliyun_webdb_1 && docker rm aliyun_webdb_1 && docker stop aliyun_tlbbdb_1 && docker rm aliyun_tlbbdb_1 && rm -rf /TLsf/workspace/tlbb
# step 2 : 上传服务端文件，解压并给相应权限 jieya_tar.sh
tar zxf tlbb.tar.gz -C /TLsf/workspace && chown -R root:root /TLsf/workspace && chmod -R 777 /TLsf/workspace

# 备用step2: 如果是zip格式才执行下面命令，与上一条命令只选其一即可，根据你上传的服务端后缀使用。 jieya_zip.sh
sudo yum -y install unzip && unzip tlbb.zip -d /TLsf/workspace && chmod -R 777 /TLsf/workspace

# step 3 ： 将上一版本的服务端备份，改名。---> set_ini.sh
cd ~/tlsf/aliyun/scripts && ./modify_ini_config.sh

# step 4 : 运行容器环境 --> run_env.sh
cd ~/tlsf/aliyun && docker-compose up -d
# 出现如下表示已经安装完成
Successfully built cdab3aeef0cd
Successfully tagged yulinzhihou/tlsf_gs:v0.1
Creating tlsf_tlbbdb_1      ... done
Creating tlsf_webdb_1       ... done
Creating tlsf_webdb_1       ... 
Creating tlsf_game_server_1 ... done

# step 5 : 开服命令如上面第二步与备用开服方案，如果不确定的残端，建议先使用备用开服命令进行开服，以查明是否有报错，如果是确定开服没问题的端，可以使用正常一键命令开服
```

- #### PHP网站环境架设（即将更新……）请加群826717146，或者访问我的[博客](https://gsgameshare.com)

- #### 一键端服务器环境（即将更新……）请加群826717146，或者访问我的[博客](https://gsgameshare.com)

- #### 一机多区环境配置（即将更新……）请加群826717146，或者访问我的[博客](https://gsgameshare.com)

