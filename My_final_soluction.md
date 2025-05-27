# Recruitment tasks overview

Case: setup working weather app with frontend and backend on any platform. Use terraform for IaC to automate setting up environment and ansible for deploying application to both front and back. 

# Overview

My soluction is spread in diffrient files around repository in each catalog. So Ansible task and its overview will be there and so on for terraform. This part is reserved for docker and bit of overview to help you navigate.

## Docker app start separately every container

1. Add your API KEY to weatherapp into .env file in following format:
```bash
APPID='keykeykeykey'
```
In my .env file i added my api key to just show to you that i manage to get and use the key. Overall such things should be stored in some Cyberark or similar services - this is security risk to include them here but for overall purpose of our task i left it here.

2. Run backend container
```bash
source .env
docker build backend/. -t weatherapp_backend:1.1
docker run -d --rm -p 9000:9000 -e APPID=$APPID --name weatherapp_backend -t weatherapp_backend
```

3. Run frontend container
```bash
docker build frontend/. -t weatherapp_frontend:1.1
docker run -d --rm -p 8000:8000 --name weatherapp_frontend -t weatherapp_frontend
```

4. Optional: change location weather
To do so you need to change backend default env parameter. I was not part of the task but i wanted to just expirement to see how Api works with diffrient cites.
```bash
docker run -d --rm -p 9000:9000 -e APPID=$APPID -e TARGET_CITY="Helsinki,fi" --name weatherapp_backend -t weatherapp_backend
```

## Docker compose example

1. (same idea as above) Add your API KEY to weatherapp into .env file in following format:

```bash
APPID='keykeykeykey'
```

2. Build backend image
```bash
docker build backend/. -t weatherapp_backend:1.1
```

3. Build frontend image
```bash
docker build frontend/. -t weatherapp_frontend:1.1
```

4. Start containers with compose
```bash
docker-compose up
```

5. Optional: change location weather
To do so you need to change backend default env parameter: edit .env file and change tag of city in TARGET_CITY variable

## Terraform
Terraform code deploys two servers in one private network onto Microsoft Azure. Subscription should be kept in Vault same as API keys, but for sake of clarity it was left in main.tf. Via subscription_id terraform know where to deploy infrastructure (single private network, two servers in it, one with public IP). See My_soluction_Terraform.md file in `Terraform` directory for futher explanations.

Remember to change subscription_id in main.tf to one of your desire and alter all the variables you prefer in terraform.tfvars. 
Then:

```bash
az login
terraform init
terraform plan
terraform apply
```
## Ansible
There is some documentation in My_soluction_Ansible.md file in `Ansible` directory. Basically ansible is meant to prepare and deploy application onto infrastructure. By running 3 separate playbooks we prepare env, deploy app and deploy webserver `nginx`. 

```bash
ansible-playbook -i inventory server_setup.yml --diff
ansible-playbook -i inventory app_setup.yml --diff
ansible-playbook -i inventory nginx.yml --diff
```
or
```bash
ansible-playbook -i inventory master_playbook.yml --diff
```

  To make sure you can access app over internet one need to add entry to ithis `/etc/hosts` file with the public IP deployed in terraform part and weatherapp.local url

```bash
11.22.33.44 weatherapp.local
```
! replace `11.22.33.44` with your public IP

In mine case to keep static public IP address I would need to pay in addtion (i think) to microsoft there for while runing the ansible it would be best to use dns name rather than ip that in my case changes each time i run mashine. So remember to edit inventory file before you run playbook.

### The application is faulty and doesnt serve external js resources due to CORS policies in modern browsers.

Overall app works - I validated it from our vms that we recive html and also api result. 

# would-be-nice-to-haves

1. Working JS app :D Now it fails on public serving webserver due to CORS policies
2. Gathering secrets in external engine and using variables to pull them via ansible instead of having them in the code directly (like .env API KEY, subscription_id etc)
3. Adding host_vars/group_vars to ansible to further parametrise values like nginx install version, docker install version, user, app user, app directory etc
4. Newer node support for the backend and frontend applications
5. Making parameters in terraform variables like: subnet, network etc
6. Firewall policies for terraform (network security groups)