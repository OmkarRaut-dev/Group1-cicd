resource "aws_internet_gateway" "IGW" {
  vpc_id    = aws_vpc.blue-green-deploy.id


  tags = {
    Name = "IGW"
  }
}


resource "aws_nat_gateway" "NAT_GW" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
  #connectivity_type = "private"
 
  tags = {
    Name = "NAT_GW"
  }
  #depends_on = [aws_internet_gateway.IGW]

}

resource "aws_nat_gateway" "NAT_GW1" {
  allocation_id = aws_eip.nat_eip1.id
  subnet_id     = aws_subnet.public1.id
  #connectivity_type = "private"

  tags = {
    Name = "NAT_GW1"
  }
  #depends_on = [aws_internet_gateway.IGW]
}
