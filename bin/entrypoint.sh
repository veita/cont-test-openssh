#!/bin/sh

printf "%s Start SSHD\n\n" `date --utc +%Y-%m-%dT%H:%M:%SZ`

exec /usr/sbin/sshd -D -e
