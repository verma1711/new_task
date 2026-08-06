#!/bin/bash

set -e

if ! command -v docker >/dev/null 2>&1
then
    dnf install -y docker --allowerasing
fi

systemctl enable docker
systemctl start docker

mkdir -p /usr/local/lib/docker/cli-plugins

wget \
  https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -O /usr/local/lib/docker/cli-plugins/docker-compose

wget \
  https://github.com/docker/buildx/releases/download/v0.29.1/buildx-v0.29.1.linux-amd64 \
  -O /usr/local/lib/docker/cli-plugins/docker-buildx

chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx

docker compose version
docker buildx version