#!/bin/bash
set -e

echo Generate squid.conf
echo ========================

cat << EOS | tee ./squid.conf
access_log stdio:/dev/stdout common

cache_peer 10.0.2.2 parent 8080 0
never_direct allow all

http_access allow all

http_port 3128
EOS

echo ========================

# -N: No daemon mode.
exec squid -f ./squid.conf -N
