locals {
  common_tags={
    project=var.project
    environment=var.environment
    terraform=true
  }
  vpc_tags=merge(
    local.common_tags,var.tags,
    {Name="${var.project}-${var.environment}"}
  )
  final_igw=merge(
    local.common_tags,
    var.igw,
    {Name="${var.project}-${var.environment}"}
 )
 two_zones=slice(data.aws_availability_zones.available.names,0,2)

 final_public_subnet_tags=merge(
  local.common_tags,
  {Name="${var.project}-${var.project}"},
  var.public_subnet_tags

 )
}