provider "aws" {
}

module "nat" {
  source = "../app-nat"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  az_count = "${var.az_count}" 

  cidr_blocks = "${var.nat_cidrs}"
}

module "vpn" {
  source = "../app-vpn"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  az_count = "${var.az_count}" 

  cidr_blocks = "${var.vpn_cidrs}"
}

module "jump" {
  source = "../app-jump"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  az_count = "${var.az_count}" 

  cidr_blocks = "${var.jump_cidrs}"
}

module "consul" {
  source = "../app-consul"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  az_count = "${var.az_count}" 

  cidr_blocks = "${var.consul_cidrs}"
}

module "cache" {
  source = "../app-cache"

  bucket_remote_state = "${var.bucket_remote_state}"
  context_org = "${var.context_org}"
  context_env = "${var.context_env}"

  az_count = "${var.az_count}" 

  cidr_blocks = "${var.cache_cidrs}"
}
