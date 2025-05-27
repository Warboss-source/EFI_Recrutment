# Overview

It would be good to have our ansible directory in separate repository as this project was small, therefor to ease of this task it is in the same repo. Which obviously isn't a part of clean and secure enviorment.

To deploy application onto working cloud VMs I used ansible-playbook. There are three playbooks. Order of their deploy as follows:
1. server_setup.yml
2. app_setup.yml
3. nginx.yml

## server_setup.yml

This playbook sets cloud VMs up in such a way we have control over the servers

setup basic tools + we add the public key provided. I added it this way.

## app_setup.yml

This playbook will actually deploy our working weatherapp based on the code we have in git repository, install required packages and deploy docker containers

install docker, docker-compose
configure paths for applications's code
copy app code
docker-compose up --build -d

## nginx.yml

This playbook will configure frontend proxy nginx to server our docker app as webpage accssible from the internet. I wanted to forward 80 and 443 into our 8000 ports.

install nginx webserver
basic configure of nginx
prepare vhost for proxy to port 8000 (application frontend port)

# Deploy
```bash
ansible-playbook -i inventory server_setup.yml --diff
ansible-playbook -i inventory app_setup.yml --diff
ansible-playbook -i inventory nginx.yml --diff
```
or
```bash
ansible-playbook -i inventory master_playbook.yml --diff
```