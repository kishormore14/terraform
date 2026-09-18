module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.4.0"

  instance_type = "t3.micro"
  key_name      = "user1"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  ami = "ami-098f18a6382fb4b2d"

  tags = {
    Name="my-instance"
    Environment = "dev"
  }
}