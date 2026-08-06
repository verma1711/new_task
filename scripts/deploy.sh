#!/bin/bash

set -e

cd /opt/app

docker compose -f docker-compose.prod.yaml down || true

docker compose -f docker-compose.prod.yaml up -d --build