#!/bin/sh

set -e

printf "Add this to known_hosts:\n\n"

ssh-keyscan localhost > /tmp/this_known_host 2>/dev/null
cat /tmp/this_known_host

printf "\nHashed:\n\n"

ssh-keygen -Hf /tmp/this_known_host 1>/dev/null 2>/dev/null
cat /tmp/this_known_host
