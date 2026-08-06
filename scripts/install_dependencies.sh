#!/bin/bash

dnf update -y

if ! command -v docker &> /dev/null
then
    dnf install -y docker
    systemctl enable docker
    systemctl start docker
fi

dnf install -y docker-compose-plugin

systemctl enable docker
systemctl start docker