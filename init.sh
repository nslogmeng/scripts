#!/bin/bash

echo "Start init environment..."

# init Ubuntu env
sudo apt-get update
sudo apt-get install -y --no-install-recommend git ufw

echo "Setup ufw..."
ufw reset
ufw default deny
ufw allow ssh
ufw allow from 10.0.0.0/8
ufw allow from 172.16.0.0/12
ufw allow from 192.168.0.0/16