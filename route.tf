resource "aws_route_table" "internet_route_table" {
  vpc_id = aws_vpc.blue-green-deploy.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_route_table" "nat_route_table" {
  vpc_id = aws_vpc.blue-green-deploy.id
  #subnet_id     = aws_subnet.private.id
  #availability_zone= "eu-west-1a"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT_GW.id

  }

  tags = {
    Name = "nat_gateway"
  }
}

# resource "aws_route_table" "nat_route_table1" {
#   vpc_id = aws_vpc.blue-green-deploy.id
#   #subnet_id     = aws_subnet.private1.id
#   #availability_zone= "eu-west-1b"

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.NAT_GW1.id
#     #availability_zone = "eu-west-1b"

#   }

#   tags = {
#     Name = "nat_gateway"
#   }
# }

resource "aws_route_table_association" "Public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.internet_route_table.id
}


resource "aws_route_table_association" "Private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.nat_route_table.id
}


resource "aws_route_table_association" "Public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.internet_route_table.id
}


resource "aws_route_table_association" "Private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.nat_route_table.id
}