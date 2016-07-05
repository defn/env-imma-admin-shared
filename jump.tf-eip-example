module "jump" {
  source = "../app-jump"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${split(" ",null_resource.cidrs.triggers.jump)}"

  az_count = "${var.az_count}"
  nat_count = 0
  igw_count = "${var.az_count}"

  app_name = "jump"

  asg_min = 2
  asg_max = 2
}

resource "aws_eip_association" "jump" {
  instance_id = "${element(module.jump.instances,0)}"
  allocation_id = "${module.jump.allocation_id}"
}

resource "aws_security_group_rule" "jump_icmp" {
  security_group_id = "${module.jump.default_sg_id}"

  type = "ingress"
  protocol = "icmp"
  from_port = 0
  to_port = 8
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "jump_ssh" {
  security_group_id = "${module.jump.default_sg_id}"

  type = "ingress"
  protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "jump_out" {
  security_group_id = "${module.jump.default_sg_id}"

  type = "egress"
  protocol = "-1"
  from_port = 0
  to_port = 0
  cidr_blocks = [ "0.0.0.0/0" ]
}

output "jump_instances" {
  value = [ "${module.jump.instances}" ]
}

output "jump_eip" {
  value = "${module.jump.eip}"
}
