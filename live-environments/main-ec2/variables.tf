variable "instances" {
  type = map(object({
    subnet_id = string
    instance_type = string
    ami_id = string    
    user_data = optional(string, null)
  }))
  default = {}
}

variable "vpc_id" {
  type = string
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