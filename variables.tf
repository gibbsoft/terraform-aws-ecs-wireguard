variable "name" {
  type        = string
  default     = "wireguard"
  description = "A unique name for the module"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "tags"
}

variable "cloudwatch_log_retention_in_days" {
  type        = number
  default     = 90
  description = "The cloudwatch log description in days"
}

variable "ec2_instance_type" {
  type        = string
  default     = "t2.small"
  description = "The EC2 instance type to launch for the cluster"
}

variable "server_tz" {
  type        = string
  default     = "America/Los_Angeles"
  description = "The time zone for the server"
}

variable "server_url" {
  type        = string
  description = "The FQDN serving wireguard (ex: www.example.com)"
  default     = ""
}

variable "ssh_public_key" {
  type        = string
  default     = ""
  description = "The public key to use for an AWS key pair. This will enable SSH access to the ECS cluster EC2 instance. Leaving this blank will disable access."
}

variable "wireguard_peers" {
  type        = number
  default     = 0
  description = "The number of wireguard peers to configure. When using wireguard-ui set to 0 or leave as default."
}

variable "key_name" {
  type        = string
  default     = "wireguard"
  description = "The AWS Key Pair Key Name"
}

variable "ecs_enable_init" {
  type        = bool
  default     = true
  description = "Enable the ECS init process"
}

variable "images" {
  type = map(map(string))
  default = {
    wireguard = {
      name = "linuxserver/wireguard"
      tag  = "v1.0.20210424-ls36"
    }
  }
  description = "Map of container images"
}

variable "ecs_node_ami_filter" {
  type        = string
  default     = "amzn2-ami-ecs-hvm-2.0.20210916-x86_64-ebs"
  description = "Filter for ECS node AMI"
}

variable "max_number_of_azs" {
  type        = number
  default     = 3
  description = "Max number of AZs to configure"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC CIDR range"
}