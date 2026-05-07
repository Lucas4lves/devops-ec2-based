variable "ami_id" {
  type = string
  default = ""
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "instance_name" {
  type = string
  default = "devops-ec2-based"
}

variable "custom_tags" {
  type = map(string)
  default = {}
}

variable "security_group_ids" {
  type = list(string)
  default = []
}

variable "subnet_id" {
  type = string
  default = ""
}