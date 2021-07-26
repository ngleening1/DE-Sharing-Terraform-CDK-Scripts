# DESharing-Terraform-CDK-Scripts
This repository contains scripts used at DE Sharing Session
Date: 30/07/2021

## CDKTF Demo
This folder consists of code to set up a simple VPC, subnet and EC2 instance with **Terraform Cloud Development Kit**.

Prerequisite:
1. Python Pipenv
2. AWS CLI
3. Terraform
4. NPM
5. CDK
```
npm install –g cdktf-cli
```

To run code, download folder into local path and run:
```
cdktf get
cdktf synth
```
Ensure that you are pointing to the correct folder.
New folders "imports" and "cdktf.out" will be generated.

Change directory to ../CDK-demo/cdktf.out/stacks/CDK-demo and run:
```
terraform init
terraform plan
terraform apply -auto-approve
```

Ensure that AWS Credentials are correctly configured. The relevant resources will be set up in AWS after running the above code.

To remove resources, run:
```
terraform destroy -auto-approve
```


## Terraform Demo
This folder consists of code to set up a simple VPC, subnet and EC2 instance with **Terraform Hashicorp Language**.

Prerequisite:
1. AWS CLI
2. Terraform (Add to PATH)

To run code, download folder into local path and run:
```
terraform init
terraform plan
terraform apply -auto-approve
```

Ensure that AWS Credentials are correctly configured. The relevant resources will be set up in AWS after running the above code.

To remove resources, run:
```
terraform destroy -auto-approve
```
