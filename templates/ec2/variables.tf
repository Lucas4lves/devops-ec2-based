variable "instances_count" {
  type = number
  default = 1
}

variable "instances" {
  type = map(object({
    subnet_id = string
    instance_type = string
    ami_id = string    
    user_data = optional(string, null)
  }))
  default = {}
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

variable "security_group_ids" {
  type = list(string)
  default = []
}

variable "iam_instance_profile" {
  type = string
}

variable "subnet_id" {
  type = string
  default = ""
}

variable "user_data" {
  type = string
  default = null
}