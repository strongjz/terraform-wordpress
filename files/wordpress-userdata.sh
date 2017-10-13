#!/bin/bash -e

sleep 30

echo "apt-get update"
apt-get -y update
sleep 5

echo "apt install common"
apt-get -y install python27
sleep 5

echo "apt-get Install ansible"
apt-get -y install ansible

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"

unzip awscli-bundle.zip

./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

aws s3 cp --recursive s3://terraform-wordpress-demo/wordpress-nginx.zip ~ --region us-east-1

unzip wordpress-nginx.zip

cd ~/wordpress-nginx/

ansible-playbook -i "localhost" -c local site.yml
