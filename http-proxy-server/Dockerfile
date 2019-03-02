FROM alpine:3.9

RUN apk --update --no-cache add 'squid<5'

# TZ環境変数でタイムゾーンを変更できるようにするため
RUN apk --update --no-cache add tzdata

WORKDIR /workdir
RUN chown squid:squid ./

COPY ./start-proxy.sh ./

# ログを標準出力に出すために必要
USER squid

CMD ["./start-proxy.sh"]
