FROM centos:6.8

WORKDIR /home/tlbb

RUN yum clean all && yum update -y && yum check

RUN yum install -y libstdc++.i686 unixODBC.i686
RUN ln -s /usr/lib/libodbc.so /usr/lib/libodbc.so.1
COPY ./config/odbc.ini /etc/odbc.ini
COPY ./config/mysql-connector-odbc-5.1.5r1144-7.el6.i686.rpm /tmp/mysql-connector-odbc-5.1.5r1144-7.el6.i686.rpm
RUN yum localinstall -y /tmp/mysql-connector-odbc-5.1.5r1144-7.el6.i686.rpm
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' > /etc/timezone
RUN rm -f /tmp/mysql-connector-odbc-5.1.5r1144-7.el6.i686.rpm
CMD tail -f /dev/null

