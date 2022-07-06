/*
NAT Gateway is used to enable instances in private subnets to connect to the internet (for example, for software installation or updates).
Also, we will need to allocate a public static IP address for those NAT Gateways. And for that purpose, we will use another AWS service 
called Elastic IP.
*/

resource "aws_nat_gateway" "gw" {
  # The allocation ID of the Elastic IP address for the gateway
  allocation_id = var.elasticIp_id

  # The subnet ID of the subnet in which to place the gateway
  subnet_id = var.public_subnet_id

  # A map of tags to assign to the resource
  tags = var.tags 
}





