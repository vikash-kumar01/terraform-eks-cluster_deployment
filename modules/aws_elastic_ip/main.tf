/*
NAT Gateway is used to enable instances in private subnets to connect to the internet (for example, for software installation or updates).
Also, we will need to allocate a public static IP address for those NAT Gateways. And for that purpose, we will use another AWS service 
called Elastic IP.
Referring to our architecture, we need to set up two NAT Gateway and that means we gonna need two Elastic IP addresses.
*/

resource "aws_eip" "nat" {
  #EIP may require IGW to exist prior to association.
  # Use depends_on to set an explicit dependency on the IGW.
  tags = var.tags
}

variable "tags" {}

