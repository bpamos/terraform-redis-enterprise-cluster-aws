# Create a VPC
resource "aws_vpc" "redis_cluster_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    #Name = var.vpc_name
    Name = format("%s-%s-cluster-vpc", var.base_name, var.region)
  }
}

resource "aws_subnet" "re_subnet" {
  vpc_id     = aws_vpc.redis_cluster_vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.subnet_az

  tags = {
    Name = format("%s-subnet1", var.base_name)
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.redis_cluster_vpc.id
  tags = {
      Name = format("%s-igw", var.base_name)
    }
}

resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.redis_cluster_vpc.default_route_table_id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }
  tags = {
      Name = format("%s-rt", var.base_name)
    }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.re_subnet.id
  route_table_id = aws_default_route_table.route_table.id
}

## NOT REQUIRED
# resource "aws_route_table_association" "b" {
#   gateway_id     = aws_internet_gateway.igw.id
#   route_table_id = aws_default_route_table.route_table.id
# }