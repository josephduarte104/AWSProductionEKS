provider "aws" {
  region = "INSERT REGION" //example eu-west-1
  version = "~> 2.47"
}
resource "aws_eip" "nat" {
  count = 3
  vpc = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "INSERT VPC NAME" //example production-vpc
  cidr = "VPC CIDR BLOCK" //example 10.120.0.0/16

  azs = "AVAILABILTY ZONES LIST" //example ["eu-west-1b", "eu-west-1a", "eu-west-1c"]
  private_subnets = "PRIVATE SUBNETS LIST" //example ["10.120.10.0/24","10.120.11.0/24","10.120.12.0/24"]
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" : "1"
  }
  public_subnets = "PUBLIC SUBNETS LIST" // example ["10.120.0.0/24","10.120.1.0/24","10.120.2.0/24"]
  public_subnet_tags = {
    "kubernetes.io/role/elb" : "1"
  }
  enable_nat_gateway = true
  single_nat_gateway  = false
  reuse_nat_ips       = true  
  external_nat_ip_ids = aws_eip.nat.*.id
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_s3_endpoint = true
tags = {
    "Terraform" : "true"
    "Environment" : "production"
    "kubernetes.io/cluster/production-eks" : "shared"
  }
}