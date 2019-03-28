#!/bin/bash
set -e
sleep 5m
while true; do
	/usr/local/bin/php -f /var/www/html/cron.php
	sleep 15m
done
