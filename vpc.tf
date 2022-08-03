resource "aws_vpc" "blue-green-deploy" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_eip" "nat_eip1" {
  vpc = true
}
