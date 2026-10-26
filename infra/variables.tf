variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "name" {
  type    = string
  default = "hello-next"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
