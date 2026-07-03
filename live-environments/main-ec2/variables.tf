variable "instances" {
  type = map(object({
    subnet_id = string
    instance_type = string
    ami_id = string    
    user_data = optional(string, null)
  }))
  default = {}
}

variable "security_groups_config" {
  type = map(object({
    ingress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
  default = {}
}

variable "project_handler" {
  type = string
}

variable "vpc_name" {
  type = list(string)
}

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

variable "subnet_id" {
  type = string
  default = ""
}

variable "repo_branch" {
  type    = string
  default = "main"
}

variable "sg_allowed_ips" {
  type = list(string)
}