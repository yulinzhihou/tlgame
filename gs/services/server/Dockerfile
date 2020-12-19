FROM registry.cn-hangzhou.aliyuncs.com/yulinzhihou/tlsf_gs:v0.1

WORKDIR /home/tlbb

COPY ./config/odbc.ini /etc/odbc.ini
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone
CMD tail -f /dev/null