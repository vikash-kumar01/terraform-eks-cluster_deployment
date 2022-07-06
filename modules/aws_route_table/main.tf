resource "aws_route_table" "rt" {
  # The VPC ID.
  vpc_id = var.vpc_id

  route {
    # The CIDR block of the route
    cidr_block = "0.0.0.0/0"
    # Identifier of the VPC internet gateway or a virtual private gateway
    gateway_id = var.gateway_id
  }

  # A map of tags to assign to the resource
  tags =var.tags
}




