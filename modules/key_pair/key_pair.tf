resource "aws_key_pair" "auth" {
  key_name   = "${uuid()}" # unique key for avoiding duplicate
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

