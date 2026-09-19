terraform {
  backend "s3" {
    bucket       = "ishita-sample-bucket-terraform.tfstate"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  default = "dev"
}

variable "channel_name" {
  default = "ishitas3"  
}

variable "region" {
  default = "us-east-1" 
}

locals {
  bucket_name = "${var.channel_name}-bucket-${var.environment}"
  vpc_name = "${var.environment}-VPC"
}

# Create a s3 bucket
resource "aws_s3_bucket" "example" {
  bucket = local.bucket_name

  tags = {
    Name        = local.bucket_name
    Environment = var.environment
  }
}

resource "aws_vpc" "sample"{
  cidr_block = "10.0.0.0/16"
  region = var.region
  tags = {
    Environment= var.environment
    Name = local.vpc_name
  }
}

resource "aws_instance" "example" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type     = "t3.micro"
  region = var.region
  tags = {
    Environment= var.environment
    Name = "${var.environment}-ec2-instance"
  }
}

output "vpc_id" {
  value = aws_vpc.sample.id
}

output "ec2_id" {
  value = aws_instance.example.id
}