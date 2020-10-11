resource "aws_security_group" "efs-mount-targets" {
  name = "efs-mount-targets"
  description = "efs mount targets security group"
  vpc_id = "VPC ID" //example vpcXXXX
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_file_system" "production-efs" {
  creation_token = "eks-efs"

  tags = {
    Name = "production-efs"
    Terraform = "true"
    Environment = "production"
  }
}
resource "aws_efs_mount_target" "eu-west-1c" {
  file_system_id = "${aws_efs_file_system.production-efs.id}"
  subnet_id      = "AZ 1 PRIVATE CIDR" // example 10.120.10.0/24
  security_groups = ["${aws_security_group.efs-mount-targets.id}"]
}
resource "aws_efs_mount_target" "eu-west-1a" {
  file_system_id = "${aws_efs_file_system.production-efs.id}"
  subnet_id      = "AZ 2 PRIVATE CIDR" //example 10.120.11.0/24
  security_groups = ["${aws_security_group.efs-mount-targets.id}"]
}
resource "aws_efs_mount_target" "eu-west-1b" {
  file_system_id = "${aws_efs_file_system.production-efs.id}"
  subnet_id      = "AZ 3 PRIVATE CIDR" //example 10.120.12.0/24
  security_groups = ["${aws_security_group.efs-mount-targets.id}"]
}

resource "aws_security_group_rule" "ingress-mount_targets-worker_nodes" {
  description = "Allow mount targets to recive connection from worker nodes"
  source_security_group_id = "WORKER NODES SECURITY GROUP ID" //example sg-XXXXXXXXXXX
  from_port = 2049
  protocol = "tcp"
  security_group_id = "${aws_security_group.efs-mount-targets.id}"
  to_port = 2049
  type ="ingress"
}