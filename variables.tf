variable "region" {
  default = "ap-northeast-1"
}

variable "amis" {
  type = "map"
  default = {
    "ap-northeast-1" = "ami-0c3fd0f5d33134a76"
  }
}

variable "key_name" {
  default     = "id_rsa.pub"
  description = "Desired name of AWS key pair"
}

variable "public_key_path" {
  default     = "~/.ssh/id_rsa.pub"
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can connect.

Example: ~/.ssh/id_rsa.pub
DESCRIPTION
}

