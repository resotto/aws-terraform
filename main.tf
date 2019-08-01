provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_instance" "example" {
  ami                    = var.amis[var.region]
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  depends_on             = [aws_s3_bucket.example]
  #  provisioner "local-exec" {
  #    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  #  }
}

resource "aws_key_pair" "auth" {
  key_name   = "id_rsa.pub"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_security_group" "default" {
  name        = "terraform_security_group"
  description = "Used in the terraform"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "resotto"
  acl    = "private"
}

resource "aws_eip" "ip" {
  instance = aws_instance.example.id
}

/*
resource "aws_instance" "another" {
  ami = "ami-04b2d1589ab1d972c"
  instance_type = "t2.micro"
}
*/

output "ip" {
  value = aws_eip.ip.public_ip
}

output "ami" {
  value = aws_instance.example.ami
}

