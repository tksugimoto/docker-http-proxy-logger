FROM centos:7.6.1810

RUN yum -y install squid

COPY ./conf/squid.conf /etc/squid/squid.conf

# ログを標準出力に出すために必要
USER squid

# -N: No daemon mode.
CMD ["squid", "-N"]
