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
}