variable "cidr" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24","10.0.4.0/24"]
}

variable "az" {
  type    = list(any)
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}
