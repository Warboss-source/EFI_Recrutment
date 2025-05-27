
# Terraform
Configuration of the environemnt - physical part. Resources deployed to Azure. Obviously whole terraform directory should be in separate repository, but for ease of this task it is in the same repo, which obviously isn't safe or proper.


### Deployed resources with this terraform code:

|Name|Type|Location|Details|
|:---:|:---:|:---:|:-----|
|Backend|Virtual machine|Poland Central|Private IP: 10.0.1.5<br/>Public IP: -|
|Backend-osdisk|Disk|Poland Central|-|
|Frontend|Virtual machine|Poland Central|Private IP: 10.0.1.4<br/>Public IP: assigned when runed no static IP|
|Frontend-osdisk|Disk|Poland Central|-|
|nic-vm1|Network Interface|Poland Central|-|
|nic-vm2|Network Interface|Poland Central|-|
|public-ip|Public IP address|Poland Central|-|
|vm-nsg|Network security group|Poland Central|-|
|vnet|Virtual network|Poland Central|-|

## main\.tf
- General settings
- provider
- resource group definition

## network\.tf
- virtual network (`10.0.0.0/16`)
- subnet in virtual network (`10.0.1.0/24`)
- network interface 1 for frontend VM with priavte IP (dynamic from subnet `10.0.1.0/24`) and public IP (defined below)
- network interface 2 for backend VM with dynamic private IP from subnet `10.0.1.0/24`
- public IP assigned to nic 1 for frontend VM (Dynamic allocation from Azure)

## firewall\.tf
Network Security Group settings with rules securing publicly available VM
- associating defined NSG with existing subnet (`10.0.1.0/24`)
- nsg definition with rules
    - rule 100: Allow Inbound connection from everywhere to port TCP:80 (HTTP)
    - rule 101: Allow Inbound connection from everywhere to port TCP:443 (HTTPS)
    - rule 110: Allow Inbound connection to port TCP:22 (SSH)
    - rule 120: Allow all connections in vnet
    - rule 200: Deny all other inbound connections

## terraform.tfstate
`tfstate` state file of environment (creaeted dynamicly). I would be good to keep it in storage account or s3 container

## terraform.tfvars
Variable defining file. It takes variables contructed in variables.tf and allows definitions. In this case: name of resource group and file of id_rsa.pub public key file to SSH access the servers.

## var\.tf
Declaring existing in env variables, including types and, in some cases, default values. Each of these can be defined in `terraform.tfvars` overwriting default value
- resource_group_name
- location (defaults to `polandcentral`)
- admin_username (defaults to `warboss`) I let myself to use my nickname to not forget admin while testing.
- ssh_public_key_path
- vm size

## Servers\.tf
The most important file in our case - definitions of virtual machines and their configuration. It desribes exactly 2 VMs: `Frontend` and `Backend`
- name of VM
- size (Standard_B2ats_v2)
    - Standard is recommended tier
    - B – Economical burstable
    - 2 – The number of vCPUs
    - a – AMD-based processor
    - t – The smallest amount of memory in a particular size
    - s – Premium Storage capable
    - vCPUs: `2`
    - Memory (GiB): `1`
- assigning network interfaces
- setting admin ssh key from variable
- configuration of os disk 
- OS image - (Ubuntu 22.04)

# Deployment of terraform:
```bash
az login
terraform init
terraform plan
terraform apply
```