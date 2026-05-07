variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnets_cidr" {
  type = list(string)
  default = [ ]
}