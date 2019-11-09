FROM alpine:3.9

RUN apk add --update-cache --no-cache 'squid<5'

# TZ環境変数でタイムゾーンを変更できるようにするため
RUN apk add --update-cache --no-cache tzdata

# 認証ユーザー作成用 htpasswd コマンドのinstall
RUN apk add --update-cache --no-cache apache2-utils

WORKDIR /workdir
RUN chown squid:squid ./

COPY ./start-proxy.sh ./
RUN chmod 755 ./start-proxy.sh

# ログを標準出力に出すために必要
USER squid

CMD ["./start-proxy.sh"]
