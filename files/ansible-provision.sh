#!/bin/bash -e

unzip  /home/ec2-user/ansible.zip

cd /home/ec2-user/ansible

while  ! [ -x "$(command -v ansible-playbook)" ]
do
  echo 'Error: Playbook not installed yet is not installed.' >&2
  sleep 10
done

ansible-playbook -i hosts site.yml
