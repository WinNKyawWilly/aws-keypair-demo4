variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "deployment_name" {
  type        = string
  description = "Deployment Name"
}

variable "create_ssh_keypair" {
  type    = bool
  default = false
}

variable "friendly_name_prefix" {
  type    = string
  default = "wnk"
}

variable "ec2_ssh_keypair_name" {
  type        = string
  description = "Ec2 ssh keypair name"
}

variable "common_tags" {
  type        = map(string)
  description = "Map of common tags for all taggable AWS resources."
  default     = {}
}