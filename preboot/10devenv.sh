#!/bin/bash
echo "****************************************************"
echo "*  Welcome to the HP ESS Development Environment!  *"
echo "****************************************************"

PASSWORD=${PASSWORD:-password}
WEMUX_PASSWORD=${WEMUX_PASSWORD:-wemux}
echo "$PASSWORD" | sudo passwd --stdin devenv 2>&1 >/dev/null
echo "$WEMUX_PASSWORD" | sudo passwd --stdin wemux 2>&1 >/dev/null

echo " => Primary logon username: devenv, password: $PASSWORD"
echo " => Wemux logon username: wemux, password: $WEMUX_PASSWORD"
