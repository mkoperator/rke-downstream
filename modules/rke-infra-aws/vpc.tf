resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name                                     = "${var.prefix}-vpc"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${var.clusterid}" = "owned"
  }
}
resource "aws_subnet" "amazonia" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name                                     = "${var.prefix}-sub-amazonia"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${var.clusterid}" = "owned"
  }
}
resource "aws_subnet" "atlantis" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name                                     = "${var.prefix}-sub-atlantis"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${var.clusterid}" = "owned"
  }
}
resource "aws_subnet" "land" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name                                     = "${var.prefix}-sub-land"
    TFModule                                 = var.prefix
    "kubernetes.io/cluster/${var.clusterid}" = "owned"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.prefix}-gateway"
  }
}
resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id

 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "main"
  }
}