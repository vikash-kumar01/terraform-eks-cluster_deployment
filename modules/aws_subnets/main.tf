resource "aws_subnet" "subnets" {
  # The VPC ID to create in.

  vpc_id = var.vpc_id

  # The CIDR block for the subnet.
  cidr_block = var.cidr_block

  # The AZ for the subnet.
  availability_zone = var.availability_zone

  # A map of tags to assign to the resource
  tags = var.tags
}


