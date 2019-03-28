#!/bin/bash
set -e

# aria2 prepare
if [ ! -f /var/local/aria2c/aria2c.sess ]; then
	echo "preparing aria2c.sess"
	mkdir -p /var/local/aria2c
	touch /var/local/aria2c/aria2c.sess
	chown www-data:www-data -R /var/local/aria2c
	chmod +w -R /var/local/aria2c
fi

exec /entrypoint.sh "$@"
