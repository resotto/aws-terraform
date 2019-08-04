module "key_pair" {
  source = "../../modules/key_pair"
}

module "security_group" {
  source = "../../modules/security_group"
  vpc_id = aws_vpc.dev_vpc.id
}

resource "aws_instance" "dev" {
  ami                    = var.amis[var.region]
  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = aws_subnet.dev_public.id

  tags = {
    Name = "dev-ec2"
  }
}

resource "aws_eip" "ip" {
  instance = aws_instance.dev.id
}

