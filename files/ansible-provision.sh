#!/bin/bash -e

sleep 180 #wiating on userdata to complete

unzip  /home/ec2-user/ansible.zip

cd /home/ec2-user/ansible

ansible-playbook -i hosts site.yml
