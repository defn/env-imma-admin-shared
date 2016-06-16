variable "nat_cidrs"    { default = [ "172.16.0.64/28", "172.16.0.80/28" ] }
variable "vpn_cidrs"    { default = [ "172.16.0.96/28", "172.16.0.112/28" ] }
variable "jump_cidrs"   { default = [ "172.16.0.128/28", "172.16.0.144/28" ] }
variable "consul_cidrs" { default = [ "172.16.0.160/28", "172.16.0.176/28" ] }
variable "cache_cidrs"  { default = [ "172.16.0.192/28", "172.16.0.208/28" ] }

variable "az_count"     { default = 2 }

provider "aws" { }

module "nat" {
  source = "../app-nat"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${var.nat_cidrs}"

  az_count = "${var.az_count}"
}

module "vpn" {
  source = "../app-vpn"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${var.vpn_cidrs}"

  az_count = "${var.az_count}"
}

module "jump" {
  source = "../app-jump"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${var.jump_cidrs}"

  az_count = "${var.az_count}"
}

module "consul" {
  source = "../app-consul"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${var.consul_cidrs}"

  az_count = "${var.az_count}"
}

module "cache" {
  source = "../app-cache"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  cidr_blocks = "${var.cache_cidrs}"

  az_count = "${var.az_count}"
}
