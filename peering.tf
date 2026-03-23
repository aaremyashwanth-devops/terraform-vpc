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