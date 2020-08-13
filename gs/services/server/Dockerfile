FROM centos:6.8

WORKDIR /home/tlbb
ADD ./config/billing.tar.gz /home/billing/

COPY ./config/odbc.ini /etc/odbc.ini
COPY ./config/mysql-connector-odbc-5.1.5r1144-7.el6.i686.rpm /tmp/mysql-connector-odbc-5.1.5r1144-7.el6.i686.rpm

RUN yum clean all && \
    yum update -y && \
    yum check && \
    yum install -y libstdc++.i686 unixODBC.i686 && \
    ln -s /usr/lib/libodbc.so /usr/lib/libodbc.so.1 && \
    yum localinstall -y /tmp/mysql-connector-odbc-5.1.5r1144-7.el6.i686.rpm && \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone && \
    rm -f /tmp/mysql-connector-odbc-5.1.5r1144-7.el6.i686.rpm

CMD tail -f /dev/null
