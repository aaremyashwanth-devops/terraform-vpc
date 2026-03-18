# vpc
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames=true

  tags = local.vpc_tags
}
#internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = local.final_igw
}
#subnet
resource "aws_subnet" "public" {
  count=length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone=local.two_zones[count.index]
  map_public_ip_on_launch =true

  tags = merge(
  local.common_tags,
  {Name="${var.project}-${var.environment}-${local.two_zones[count.index]}"},
  var.public_subnet_tags

 )


}

 resource "aws_subnet" "private"{
  count=length(var.private_subnet)
   vpc_id = aws_vpc.main.id
   cidr_block=var.private_subnet[count.index]
   availability_zone=local.two_zones[count.index]
   tags=merge(
    local.common_tags,
    {Name="${var.project}-${var.environment}-${local.two_zones[count.index]}"}
   )
 }

 resource "aws_subnet" "database" {
  count = length(var.database_subnet)
   vpc_id=aws_vpc.main.id
   cidr_block = var.database_subnet[count.index]
   availability_zone=local.two_zones[count.index]
   tags =merge(local.common_tags,
   {Name="${var.project}-${var.environment}-${local.two_zones[count.index]}"},
   var.database_subnet_tags)
 }