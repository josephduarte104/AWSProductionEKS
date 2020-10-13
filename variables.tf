variable "region" {
  type = string
  default = "us-west-2"
}

variable "vpc_id" {
  type = string
  description = "vpc id"
  default = "vpc-04b4f10f127d7e6a3"
}

variable "eks_cluster-name" {
  type = string
  default = "production-eks"
}

variable "keypair-name" {
  type = string
  description = "ssh Keypair name"
  default = "eks-prod-kp"
}

variable "private_subnets_ids" {
  type = list(string)
  description = "Private subntes ids list"
  default = ["subnet-007f3d9d24c1b1b2d","subnet-0f848bb4df096637e","subnet-01132f5c3ee9441d9"]
}

variable "public_subnets_ids" {
  type = list(string)
  description = "Public subnets ids list"
  default = ["subnet-0861d447d2e9adec5","subnet-0012a16fb77f9a573","subnet-0be91ee5f279c1454"]
}

variable "bastion_ingress_cidr_block" {
  type = list(string)
  description = "cidr block list to allow connections in to bastion host"
  default = ["0.0.0.0/0","68.192.123.0/24"]
}

variable "worker_nodes_disk_size" {
  type = string
  description = "worker nodes disk size"
  default = "200"
}

variable "worker_nodes_instance_types" {
  type = list(string)
  description = "worker nodes instance types"
  default = ["t2.medium"]
}

variable "worker_nodes_scaling_desired_size" {
  type = string
  description = "worker nodes scaling desired size"
  default = "2"
}

variable "worker_nodes_scaling_max_size" {
  type = string
  description = "worker nodes scaling max size"
  default = "5"
}

variable "worker_nodes_scaling_min_size" {
  type = string
  description = "worker nodes scaling min size"
  default = "2"
}


