FROM centos:7.6.1810

RUN yum -y install squid

WORKDIR /workdir
RUN chown squid:squid ./

COPY ./start-proxy.sh ./

# ログを標準出力に出すために必要
USER squid

CMD ["./start-proxy.sh"]
