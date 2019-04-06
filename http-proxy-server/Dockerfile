FROM alpine:3.9

RUN apk --update --no-cache add 'squid<5'

# TZ環境変数でタイムゾーンを変更できるようにするため
RUN apk --update --no-cache add tzdata

WORKDIR /workdir

COPY ./start-proxy.sh ./
RUN chmod 755 ./start-proxy.sh

CMD ["./start-proxy.sh"]

VOLUME /var/log/squid
