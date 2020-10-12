provider "aws" {
  region = "${var.region}" //example eu-west-1
  version = "~> 2.47"
}
resource "aws_eip" "nat" {
  count = 3
  vpc = true
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "${var.vpc_id}" //example production-vpc
  cidr = "10.104.0.0/16" //example 10.120.0.0/16

  azs = ["us-west-2a","us-west-2b","us-west-2c"] //example ["eu-west-1b", "eu-west-1a", "eu-west-1c"]
  private_subnets = ["10.104.10.0/24","10.104.11.0/24","10.104.12.0/24"]
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" : "1"
  }
  public_subnets = ["10.104.0.0/24","10.104.1.0/24","10.104.2.0/24"] // example ["10.120.0.0/24","10.120.1.0/24","10.120.2.0/24"]
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