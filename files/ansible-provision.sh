#!/bin/bash -e

sleep 180 #wiating on user data to finish

unzip  ~/ansible.zip

cd ~/ansible

ansible-playbook -i hosts site.yml 1>output.log  2>&1
