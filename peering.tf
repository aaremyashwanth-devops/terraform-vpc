resource "aws_vpc_peering_connection" "peering" {
 count= var.is_peering_required ? 1 : 0
  #peer_owner_id = var.peer_owner_id

  #accecpter
  peer_vpc_id   = data.aws_vpc.selected.id
  vpc_id        = aws_vpc.main.id
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = merge(
    local.common_tags,
    {Name:"${var.project}-${var.environment}-default"}
  )
}

resource "aws_route" "public_peering" {
  count=var.is_peering_required? 1:0
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = data.aws_vpc.selected.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.selected.id
}
resource "aws_route" "private_peering" {
  count=var.is_peering_required? 1:0
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block = data.aws_vpc.selected.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.selected.id
}
resource "aws_route" "database_peering" {
  count=var.is_peering_required? 1:0
  route_table_id = aws_route_table.database_route_table.id
  destination_cidr_block = data.aws_vpc.selected.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.selected.id
}
resource "aws_route" "default_peering" {
  count=var.is_peering_required? 1:0
  route_table_id = data.aws_route_table.default.id
  destination_cidr_block = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.selected.id
}