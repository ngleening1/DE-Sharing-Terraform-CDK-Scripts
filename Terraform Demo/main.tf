// Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "Demo-VPC"
  }
}

// Create Private Subnet
resource "aws_subnet" "demo-private-subnet" {
  cidr_block        = var.private_subnet_cidr
  vpc_id            = aws_vpc.demo-vpc.id
  availability_zone = var.availability_zone

  tags = {
    Name = "Demo-Private-Subnet"
  }
}

// Create EC2 private security group
resource "aws_security_group" "demo-ec2-private-sg" {
  name        = "Demo-EC2-Private-SG"
  description = "Only allow public SG resources to access instance"
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = [var.private_ip_address]
    description = "Only allow own IP address to access instance"
  }
  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow health checks"
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Create IAM role
resource "aws_iam_role" "demo-ec2-iam-role" {
  name               = "Demo-EC2-IAM-Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement":
  [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF
}

// Attach Policies to IAM Role
resource "aws_iam_role_policy_attachment" "demo-ec2-role-policy" {
  count      = length(var.ec2_policies)
  policy_arn = element(var.ec2_policies, count.index)
  role       = aws_iam_role.demo-ec2-iam-role.name
}

// Create IAM Instance profile
resource "aws_iam_instance_profile" "demo-ec2-instance-profile" {
  name = "Demo-EC2-IAM-Instance-Profile"
  role = aws_iam_role.demo-ec2-iam-role.name
}

// Launch EC2 Instance
resource "aws_instance" "ec2-instance" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.demo-private-subnet.id
  iam_instance_profile   = aws_iam_instance_profile.demo-ec2-instance-profile.name
  vpc_security_group_ids = [aws_security_group.demo-ec2-private-sg.id]

  tags = {
    Name = "Demo EC2 Instance"
  }

  depends_on = [aws_security_group.demo-ec2-private-sg]
}