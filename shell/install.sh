#!/bin/sh

readonly SERVER_PASS="$1"
readonly SERVER_PORT="$2"

if [ "${SERVER_PASS}" == "" ]
then
    echo
    echo "  [ERROR] Password is not set!"
    echo
    echo "  Usage:"
    echo
    echo "  ./install.sh <password> <server_port>"
    echo
    exit 1
fi

if [ "${SERVER_PORT}" == "" ]
then
    echo
    echo "  [ERROR] Server port is not set!"
    echo
    echo "  Usage:"
    echo
    echo "  ./install.sh <password> <server_port>"
    echo
    exit 1
fi

sudo yum install git
sudo yum install python-setuptools && easy_install pip
sudo pip install git+https://github.com/shadowsocks/shadowsocks.git@master

firewall-cmd --permanent --zone=public --add-port=${SERVER_PORT}/tcp
firewall-cmd --reload

echo "{" > /etc/shadowsocks.json
echo "    \"server_port\": \"${SERVER_PORT}\"," >> /etc/shadowsocks.json
echo "    \"password\": \"${SERVER_PASS}\"," >> /etc/shadowsocks.json
echo "    \"method\": \"aes-256-cfb\"" >> /etc/shadowsocks.json
echo "}" >> /etc/shadowsocks.json
