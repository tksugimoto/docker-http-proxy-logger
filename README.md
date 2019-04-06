# HTTP Proxy and Logger

## 機能
* HTTP Proxyリクエストを別のHTTP Proxyサーバーへ転送する
    * レスポンスは対応するリクエスト元に返却する
* HTTP Proxyログを出力する

## 使い方
1. [docker, docker-compose をインストール](https://docs.docker.com/install/#supported-platforms)
1. 設定
    1. 設定ファイルを作成: `.env.example` を `.env` にコピー
        ```sh
        cp .env.example .env
        ```
    1. 設定ファイル `.env` を必要に応じて編集
        - ※ Docker Machine を使っている場合は、`HTTP_PROXY_SERVER_BIND_IP_PORT` には `127.0.0.0/8` のIPではなく、 `docker-machine ip` で得られるIPを設定する必要がある
            ```sh
            # コンテナ内の HTTP Proxy Server のbindをhost側につなげる際のhost側の待ち受けIP:PORT
            HTTP_PROXY_SERVER_BIND_IP_PORT=127.0.0.1:3128
            ```
            ```
            $ docker-machine ip
            192.168.99.100
            ```

1. HTTP Proxyサーバーを起動
    ```sh
    docker-compose up -d
    ```
1. ログを閲覧
    ```sh
    docker-compose logs -f
    ```
