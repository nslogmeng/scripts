#!/bin/bash

SS_VERSION='v3.35'
IP=$1
PORT=$2
SS_PASSWORD=$3

if [ -z "$IP" ]; then
    echo 'ip is null'
    exit 1
fi

if [ -z "$PORT" ]; then
    echo 'port is null'
    exit 1
fi

echo "Start init environment..."

# init Ubuntu env
sudo apt-get update
sudo apt-get install -y --no-install-recommend git ufw

echo "Setup shadowsocks-libev..."

# https://github.com/shadowsocks/shadowsocks-libev
sudo apt-get install --no-install-recommends gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev pkg-config

cd /tmp
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git checkout $SS_VERSION
git submodule update --init --recursive

./autogen.sh && ./config && make
sudo make install

cat > /etc/shadowsocks.json <<EOF
{
    "server":"$IP",
    "server_port":$PORT,
    "local_port":1080,
    "password":"$SS_PASSWORD",
    "timeout":300,
    "method":"aes-256-gcm"
}
EOF

cat > /etc/systemd/system/shadowsocks.service <<EOF
[Unit]
Description=Shadowsocks

[Service]
TimeoutStartSec=0
ExecStart=/usr/local/bin/ss-server -c /etc/shadowsocks.json

[Install]
WantedBy=multi-user.target
EOF

systemctl enable shadowsocks
systemctl start shadowsocks

# enable TCP bbr https://www.cxyzjd.com/article/qq_41535189/97491991
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
sysctl net.ipv4.tcp_available_congestion_control
sysctl net.ipv4.tcp_congestion_control
lsmod | grep bbr

echo "Setup ufw..."
ufw reset
ufw default deny
ufw allow ssh
ufw allow from 10.0.0.0/8
ufw allow from 172.16.0.0/12
ufw allow from 192.168.0.0/16
ufw allow ${PORT}/tcp
ufw allow ${PORT}/udp

systemctl status shadowsocks