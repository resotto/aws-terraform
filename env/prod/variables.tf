variable "region" {
  default = "ap-northeast-1"
}

variable "amis" {
  type = "map"
  default = {
    "ap-northeast-1" = "ami-0c3fd0f5d33134a76"
  }
}

