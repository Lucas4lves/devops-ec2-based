variable "instance_name" {
  type = string
}

variable "vpc_name" {
  type = list(string)
  default = []
}