Terraform scripts for building out a Base VPC, OpenVPN, Subnets, Routes, Routing Tables, VPC Endpoint, Cloudtrail and IAM groups.

#Prereq

Before running this Accept the Terms and Services for OpenVPN Access Server in AWS Market Place, Youll need to login into your AWS account to do so

https://aws.amazon.com/marketplace/fulfillment?productId=fe8020db-5343-4c43-9e65-5ed4a825c931&ref_=dtl_psb_continue&region=us-east-1

Terraform v0.9.11
GNU Make 3.81

#Runs the Terraform plan command
make plan

#Runs the Terraform apply
make apply


#ansible role base on Ansible Example
https://github.com/ansible/ansible-examples/tree/master/wordpress-nginx
