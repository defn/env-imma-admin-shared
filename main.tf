variable "az_count"     { default = 2 }

provider "aws" { }

resource "null_resource" "cidrs" {
  triggers = {
    nat    = "${data.terraform_remote_state.env.vpc_net16}.0.64/28 ${data.terraform_remote_state.env.vpc_net16}.0.80/28"
    vpn    = "${data.terraform_remote_state.env.vpc_net16}.0.96/28 ${data.terraform_remote_state.env.vpc_net16}.0.112/28"
    jump   = "${data.terraform_remote_state.env.vpc_net16}.0.128/28 ${data.terraform_remote_state.env.vpc_net16}.0.144/28"
    consul = "${data.terraform_remote_state.env.vpc_net16}.0.160/28 ${data.terraform_remote_state.env.vpc_net16}.0.176/28"
    cache  = "${data.terraform_remote_state.env.vpc_net16}.0.192/28 ${data.terraform_remote_state.env.vpc_net16}.0.208/28"
  }
}

module "nat" {
  source = "../app-nat"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${split(" ",null_resource.cidrs.triggers.nat)}"

  az_count = "${var.az_count}"

  app_name = "nat"
}

output "nat_ids" {
  value = [ "${module.nat.nat_ids}" ]
}

output "nat_eips" {
  value = [ "${module.nat.nat_eips}" ]
}

module "vpn" {
  source = "../app-vpn"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${split(" ",null_resource.cidrs.triggers.vpn)}"

  az_count = "${var.az_count}"

  app_name = "vpn"
}

module "jump" {
  source = "../app-jump"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${split(" ",null_resource.cidrs.triggers.jump)}"

  az_count = "${var.az_count}"

  app_name = "dump"
}

module "consul" {
  source = "../app-consul"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${split(" ",null_resource.cidrs.triggers.consul)}"

  az_count = "${var.az_count}"

  app_name = "consul"
}

module "cache" {
  source = "../app-cache"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${split(" ",null_resource.cidrs.triggers.cache)}"

  az_count = "${var.az_count}"

  app_name = "cache"
}
