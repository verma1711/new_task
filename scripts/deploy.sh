#!/bin/bash

set -e

cd /opt/app

docker compose -f docker-compose.prod.yml down || true

docker compose -f docker-compose.prod.yml up -d --build