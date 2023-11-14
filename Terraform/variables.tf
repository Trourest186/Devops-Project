# Input Variables
# =================================== Using for EC2-instances ===================================
variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "us-east-1"
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc" # Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-09-19
}

variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 1
}

# For VPC
variable "project" {}

variable "vpc_cidr" {}

variable "sbit" {}

variable "name" {}

# For EC2 
variable "key_name" {}

variable "region" {}

variable "instance_type" {}

variable "ami_type" {}

# variable "create_key_pair" {}