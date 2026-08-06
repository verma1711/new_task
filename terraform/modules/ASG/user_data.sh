#!/bin/bash

dnf update -y --allowerasing
dnf install -y docker ruby wget --allowerasing

systemctl enable docker
systemctl start docker

cd /home/ec2-user

wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install

chmod +x ./install
./install auto

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