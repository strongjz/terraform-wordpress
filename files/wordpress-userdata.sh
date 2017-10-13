#!/bin/bash -e

sleep 30
echo "yum install common"
sudo yum install -y python git python-devel
sleep 5
echo "Apt update"
sudo yum -y update

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

sudo python get-pip.py

echo "yum Install ansible"
sudo  pip install ansible

curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"

unzip awscli-bundle.zip

./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
