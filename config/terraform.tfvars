vpc_config = {
    
    vpc01 = {
       
       vpc_cidr_block = "192.168.0.0/16"
       
        tags= {
           
           "Name" = "main"

       }
     
    }
}


subnet_config = {

        "public-us-east-1a" = {

            vpc_name   = "vpc01"
            cidr_block = "192.168.0.0/18"
            availability_zone =  "us-east-1a"

              tags = {
                 "Name"                      = "public-us-east-1a"
                 "kubernetes.io/cluster/eks" = "shared"
                 "kubernetes.io/role/elb"    = 1
         }

        }

        "public-us-east-1b"= {

            vpc_name   = "vpc01"
            cidr_block  = "192.168.64.0/18"
            availability_zone =  "us-east-1b"

              tags = {
                 "Name"                      = "public-us-east-1b"
                 "kubernetes.io/cluster/eks" = "shared"
                 "kubernetes.io/role/elb"    = 1
        }

        }
        "private-us-east-1a" = {

            vpc_name   = "vpc01"
            cidr_block = "192.168.128.0/18"
            availability_zone =  "us-east-1a"

              tags = {
                 "Name"                      = "private-us-east-1a"
                 "kubernetes.io/cluster/eks" = "shared"
                 "kubernetes.io/role/elb"    = 1
         }

        }

        "private-us-east-1b"= {

            vpc_name   = "vpc01"
            cidr_block  = "192.168.192.0/18"
            availability_zone =  "us-east-1b"

              tags = {
                 "Name"                      = "private-us-east-1b"
                 "kubernetes.io/cluster/eks" = "shared"
                 "kubernetes.io/role/elb"    = 1
        }
        }
}


internet_gw_config = {

     igw01 = {

            vpc_name   = "vpc01"

              tags = {
                "Name" = "main"
              }                
     }
}

elastic_ip_config = {

  eip01 = {

    tags = {

      Name = "nat1"
    }
  }
  eip02 = {

    tags = {

      Name = "nat2"
    }
  } 
}

aws_natGW_config = {
 
  natgw01 = {

   eip_name   = "eip01"
   subnet_name =  "public-us-east-1a"
    tags = {
      "Name" = "natgw01"
     }  
   }  
  natgw02 = {

   eip_name   = "eip02"
   subnet_name =  "public-us-east-1b"
    tags = {
      "Name" = "natgw02"
     }  
   }   
}


aws_route_table_config = {

    RT01 = {

       private      = 0  
       vpc_name     = "vpc01"      
       gateway_name = "igw01"
       tags = {
          "Name" = "public"
      }       
    }
    RT02 = {
       
       private      = 1  
       vpc_name     = "vpc01"      
       gateway_name = "natgw01"
       tags = {
          "Name" = "private1"
       }       
    }
    RT03 = {

       private      = 1  
       vpc_name     = "vpc01"      
       gateway_name = "natgw02"
       tags = {
          "Name" = "private2"
      }       
    }
}

route_table_association_config = {

      RT01Assoc = {
       
        subnet_name =  "public-us-east-1a" 
        route_table =   "RT01"   

      }
      RT02Assoc = {
       
        subnet_name =  "public-us-east-1b" 
        route_table =   "RT01"   

      }
      RT03Assoc = {
       
        subnet_name =   "private-us-east-1a" 
        route_table =   "RT02"   

      }
      RT04Assoc = {
       
        subnet_name =   "private-us-east-1b"
        route_table =   "RT03"   

      }
}


aws_eks_cluster_config = {

      "01" = {        

        subnet1 = "public-us-east-1a"
        subnet2 = "public-us-east-1b"
        subnet3 = "private-us-east-1a"
        subnet4 = "private-us-east-1b"

        tags = {
             "Name" =  "demo-cluster"
         }  
      }
}

eks_node_group_config = {

#   "node1" = {
#          eks_cluster             = "01"
#         node_group_name          = "node1"
#         nodes_iam_role           = "eks-node-group-general1"

#         private_subnet1          = "private-us-east-1a"
#         private_subnet2          = "private-us-east-1b"

#         tags = {
#              "Name" =  "node1"
#          } 
#   }
  "node2" = {
        eks_cluster             = "01"
        node_group_name          = "node2"
        nodes_iam_role           = "eks-node-group-general2"

        private_subnet1          = "private-us-east-1a"
        private_subnet2          = "private-us-east-1b"

        tags = {
             "Name" =  "node2"
         } 
  }
}
