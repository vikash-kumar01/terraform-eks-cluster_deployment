resource "aws_route_table_association" "public" {
  # The subnet ID to create an association
  subnet_id = var.subnet_id

  # The ID of the routing table to associate with
  route_table_id = var.route_table_id

}



