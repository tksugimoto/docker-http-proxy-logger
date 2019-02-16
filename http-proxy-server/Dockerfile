FROM alpine:3.8

RUN apk --update --no-cache add squid

WORKDIR /workdir
RUN chown squid:squid ./

COPY ./start-proxy.sh ./

# ログを標準出力に出すために必要
USER squid

CMD ["./start-proxy.sh"]
