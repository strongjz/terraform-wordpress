Terraform scripts for building out a Base VPC, OpenVPN, Subnets, Routes, Routing Tables, VPC Endpoint, Cloudtrail and IAM groups.

#Prereq

Before running this Accept the Terms and Services for OpenVPN Access Server in AWS Market Place, Youll need to login into your AWS account to do so


Tested with

OpenVPN

https://aws.amazon.com/marketplace/fulfillment?productId=fe8020db-5343-4c43-9e65-5ed4a825c931&ref_=dtl_psb_continue&region=us-east-1

Cento 6 with updates HVM
https://aws.amazon.com/marketplace/pp/B00NQAYLWO?qid=1507906245000&sr=0-1&ref_=srh_res_product_title

Terraform v0.9.11

GNU Make 3.81

ansible 2.3.2.0

Need to create a secrets.tfvars file with these vars

aws_profile - name of the AWS profile you using. Terraform code assumes you are running under an AWS profile

openvpn_admin_pw - open vpn admin password

admin_ip - IP to allow admin access to certain features

#Runs the Terraform plan command

make plan

#Runs the Terraform apply

make apply


#Ansible role base on Ansible Example

https://github.com/ansible/ansible-examples/tree/master/wordpress-nginx

This terraform creates

1 OpenVPN Access server

3 Public Subnet
3 Private Subnets
3 VPN subnets
3 Database Subnets

All Subnets, NACL's and Route tables for all the subnets

1 VPC
3 Wordpress instances
1 Wordpress Mysql database

S3 bucket for cloudtrail

Nat Gateway
Internet gateway
