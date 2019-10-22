#!/bin/sh
set -e

if [ "$PROXY_FORWARDING_HOSTNAME" = "" ] || [ "$PROXY_FORWARDING_PORT" = "" ]; then
	readonly is_direct=true
fi

if [ "$PROXY_AUTH_USERNAME" != "" ] && [ "$PROXY_AUTH_PASSWORD" != "" ]; then
	readonly use_auth=true
	# -c  Create a new file.
	# -b  Use the password from the command line rather than prompting for it.
	htpasswd -cb ./.squid-passwd $PROXY_AUTH_USERNAME $PROXY_AUTH_PASSWORD
fi

echo Generate squid.conf
echo ========================

cat <<- EOS | tee ./squid.conf
	logformat custom   %>a %[ui %[un [%{%Y/%m/%d %H:%M:%S %z}tl] "%rm %ru HTTP/%rv" %>Hs %<st "%{Referer}>h" "%{User-Agent}>h" %Ss:%Sh
	access_log stdio:/dev/stdout custom

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

if [ "$use_auth" = "true" ]; then
	cat <<- EOS | tee -a ./squid.conf

		auth_param basic program /usr/lib/squid/basic_ncsa_auth $(pwd)/.squid-passwd
		auth_param basic credentialsttl 48 hours

		acl auth proxy_auth REQUIRED
		http_access allow auth
		http_access deny all
	EOS
else
	cat <<- EOS | tee -a ./squid.conf

		http_access allow all
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
