#!/bin/bash
set -e
aria2c --disable-ipv6=true --enable-rpc --rpc-allow-origin-all --continue=true --daemon=false --log=- --check-certificate=false --save-session=/var/local/aria2c/aria2c.sess --save-session-interval=2 --continue=true --input-file=/var/local/aria2c/aria2c.sess --rpc-save-upload-metadata=true --force-save=true --log-level=warn
