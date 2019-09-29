#!/bin/sh
set -e

if [ "$PROXY_FORWARDING_HOSTNAME" = "" ] || [ "$PROXY_FORWARDING_PORT" = "" ]; then
	readonly is_direct=true
fi

echo Generate squid.conf
echo ========================

cat <<- EOS | tee ./squid.conf
	access_log stdio:/dev/stdout common

	http_access allow all

	http_port 3128

	# Avoid pid creation error when launching by squid user
	pid_filename none

	# To reduce wait time at stop
	shutdown_lifetime 1 seconds
EOS

if [ "$is_direct" != "true" ]; then
	cat <<- EOS | tee -a ./squid.conf

		cache_peer ${PROXY_FORWARDING_HOSTNAME} parent ${PROXY_FORWARDING_PORT} 0
		never_direct allow all
	EOS
fi

echo ========================

echo
echo Proxy started

if [ "$is_direct" = "true" ]; then
	echo "  Parent proxy: none"
else
	echo "  Parent proxy: http://${PROXY_FORWARDING_HOSTNAME}:${PROXY_FORWARDING_PORT}/"
fi

# -N: No daemon mode.
exec squid -f ./squid.conf -N
