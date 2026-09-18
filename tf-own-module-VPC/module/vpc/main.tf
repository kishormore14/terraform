resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block
  tags       = {
    Name = var.vpc_config.name
  }
}
resource "aws_subnet" "main" {
  for_each          = var.subnet_config
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = each.key
  }
}