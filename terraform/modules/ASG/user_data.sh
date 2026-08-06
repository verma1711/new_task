#!/bin/bash

set -e

dnf update -y --allowerasing
dnf install -y docker ruby wget --allowerasing

systemctl enable docker
systemctl start docker

mkdir -p /usr/local/lib/docker/cli-plugins

wget \
  https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -O /usr/local/lib/docker/cli-plugins/docker-compose

chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

cd /tmp

wget -O install \
  https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install

chmod +x install
./install auto

systemctl daemon-reload
systemctl enable codedeploy-agent
systemctl start codedeploy-agent

mkdir -p /opt/app

cat <<EOF > /opt/app/.env
DB_HOST=${db_host}
DB_USER=${db_username}
DB_PASSWORD=${db_password}
DB_NAME=${db_name}
DB_PORT=3306
EOF