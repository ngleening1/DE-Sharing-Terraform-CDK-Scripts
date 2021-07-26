variable region {
  type = string
  description = "Region to deploy AWS resources"
  default = "ap-southeast-1"
}

// Variables for VPC
variable "vpc_cidr" {
  type = string
  description = "VPC CIDR Block"
  default = "10.0.0.0/16"
}

// Variables for Private Subnet
variable "private_subnet_cidr" {
  type = string
  description = "Private Subnet CIDR"
}

variable  "availability_zone" {
  type = string
  description = "Availability Zone for Subnet"
}

// Variables for EC2
variable "private_ip_address" {
  type = string
  description = "IP address of your own device to allow SSH access"
}

variable "ec2_policies" {
  type = list(string)
  default = ["arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
  ]
}

variable "ec2_ami" {
  type = string
  description = "AMI to launch"
}

variable "ec2_instance_type" {
  type = string
  description = "EC2 Instance type to launch"
}