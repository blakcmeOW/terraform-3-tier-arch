#Terraform Three Tier Web App
---
##Objective
Deploy an Infrastructure using Terraform with Three Tier Web application

To deploy an infrastructure:

1. Install Terraform

**For Windows**
>choco install terraform

**For Debian-based distros
>sudo apt install terraform

2. Initialize Terrform & Validate
>terraform init
>terraform validate

*Note: There must be a message showing a success upon running **"terraform init"***
*Validate first the error and run again the command above*

3. To deploy, the following command below
>>terraform plan
*Note: Running **terraform plan** command was for checking the terraform code*
>>terraform apply
*Note: Running **terraform apply** command was for deployment of the code*
*DO NOT USE **--auto approve** tag upon running terraform apply so that, the list changes must be appeared first.*

To delete the infrastructure deployed on AWS, run the command below:
>>terraform destroy
*Using **destroy** refers to deletion of any resources applied on the code.*

