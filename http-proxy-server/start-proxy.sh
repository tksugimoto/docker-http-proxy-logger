#!/bin/sh
set -e

echo Generate squid.conf
echo ========================

cat << EOS | tee ./squid.conf
access_log daemon:/var/log/squid/access.log common

http_access allow all

http_port 3128

# To reduce wait time at stop
shutdown_lifetime 1 seconds
EOS

echo ========================

echo
echo Proxy started

# -N: No daemon mode.
exec squid -f ./squid.conf -N
