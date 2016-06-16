variable "nat_cidrs" {}
variable "vpn_cidrs" {}
variable "jump_cidrs" {}
variable "consul_cidrs" {}
variable "cache_cidrs" {}

variable "az_count" {}

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
