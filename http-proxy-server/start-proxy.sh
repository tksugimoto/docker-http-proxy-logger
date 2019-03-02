#!/bin/sh
set -e

echo Generate squid.conf
echo ========================

cat << EOS | tee ./squid.conf
access_log stdio:/dev/stdout common

cache_peer ${PROXY_FORWARDING_HOSTNAME} parent ${PROXY_FORWARDING_PORT} 0
never_direct allow all

http_access allow all

http_port 3128

# Avoid pid creation error when launching by squid user
pid_filename none
EOS

echo ========================

echo
echo Proxy started
echo "  Parent proxy: http://${PROXY_FORWARDING_HOSTNAME}:${PROXY_FORWARDING_PORT}/"

# -N: No daemon mode.
exec squid -f ./squid.conf -N
