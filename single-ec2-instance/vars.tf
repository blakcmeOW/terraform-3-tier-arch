variable "region" {
  default = "ap-southeast-1"
}

variable "zone1" {
  default = "ap-southeast-1a"
}

variable "webuser" {
  default = "ubuntu"
}

variable "amiID" {
  type = map(any)
  default = {
    ap-southeast-1 = "ami-06650ca7ed78ff6fa"
    ap-southeast-2 = "ami-003f5a76758516d1e"
  }
}