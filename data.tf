data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_vpc" "selected" {
  default = true
}
data "aws_route_table" "default" {
  vpc_id=data.aws_vpc.default.id
  filter {
    name="association.main"
    values = ["true"]
  }
}