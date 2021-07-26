//terraform {
//    backend "local" {}
//}

terraform {
    backend "s3" {
        region = "ap-southeast-1"
        bucket = "demo-terraform-state-storage"
        key = "terraform.tfstate"
    }
}


terraform {
    required_version = ">= 1.0.0"
    required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "3.50.0"
        }
        local = {
            source  = "hashicorp/local"
            version = "2.1.0"
        }
    }
}

provider "aws" {
    region = var.region
}