resource "aws_internet_gateway" "main" {
  # The VPC ID to create in.
  vpc_id = var.vpc_id

  # A map of tags to assign to the resource
  tags = var.tags
}
