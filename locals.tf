locals {
  PORT_SSH         = 22
  PORT_HTTPS       = 443
  PORT_WIREGUARD   = 51820
  PORT_NFS         = 2049
  PORT_HEALTHCHECK = 32767

  CIDR_IPV4_INTERNET = "0.0.0.0/0"

  POSIX_USER  = 0
  POSIX_GROUP = 0

  wireguard_container_image = contains(keys(var.images.wireguard), "digest") ? format("%s@%s", var.images.wireguard.name, var.images.wireguard.digest) : format("%s:%s", var.images.wireguard.name, var.images.wireguard.tag)

  required_azs = slice(data.aws_availability_zones.available.names, 0, var.max_number_of_azs)

  private_subnets = [for idx, subnet in local.required_azs : cidrsubnet(var.vpc_cidr, 8, 1 + idx)]
  public_subnets  = [for idx, subnet in local.required_azs : cidrsubnet(var.vpc_cidr, 8, 101 + idx)]
}