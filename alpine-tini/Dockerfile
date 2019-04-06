FROM alpine:3.9

RUN apk --update add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]
