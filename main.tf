module "vpc_module" {

    source = "./modules/aws_vpc"

    for_each = var.vpc_config

    vpc_cidr_block =  each.value.vpc_cidr_block
    tags           = each.value.tags
}


module "aws_subnet" {
  
  source = "./modules/aws_subnets"

  for_each = var.subnet_config
 
  vpc_id            =  module.vpc_module[each.value.vpc_name].vpc_id
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  tags              = each.value.tags
}

output "subnet_ids" {
    value = module.aws_subnet
    #value = [for subnet in module.aws_subnet : id]
}

module "internet_gw" {

  depends_on = [
    module.vpc_module
  ]
  
  source = "./modules/aws_internetGW"
  
  for_each = var.internet_gw_config
  
  vpc_id            =  module.vpc_module[each.value.vpc_name].vpc_id
  tags              =  each.value.tags
}


module "elastic_ip" {
  depends_on = [
    module.internet_gw
  ]
  
  source = "./modules/aws_elastic_ip"
  
  for_each = var.elastic_ip_config

   tags = each.value.tags 
}


module "natGw" {
  
  source = "./modules/aws_natGW"
  
  for_each = var.aws_natGW_config

  elasticIp_id     =  module.elastic_ip[each.value.eip_name].elasticIp_id
  public_subnet_id =  module.aws_subnet[each.value.subnet_name].subnet_id
  tags             =  each.value.tags 
}



module "route_table" {

   source = "./modules/aws_route_table"
  
   for_each = var.aws_route_table_config

    vpc_id            =  module.vpc_module[each.value.vpc_name].vpc_id
    gateway_id        =  each.value.private == 0 ? module.internet_gw[each.value.gateway_name].internetgw_id : module.natGw[each.value.gateway_name].natgw_id
    tags              = each.value.tags  
}



module "route_table_association" {

   source = "./modules/aws_route_table_association"
  
   for_each = var.route_table_association_config

    subnet_id         =  module.aws_subnet[each.value.subnet_name].subnet_id
    route_table_id    =  module.route_table[each.value.route_table].routeTable_id
}

module "aws_eks_cluster" {

   source = "./modules/aws_eks"
  
   for_each = var.aws_eks_cluster_config

    eks_cluster_name              = var.cluster-name 
    subnet_ids                    = [module.aws_subnet[each.value.subnet1].subnet_id,module.aws_subnet[each.value.subnet2].subnet_id,module.aws_subnet[each.value.subnet3].subnet_id,module.aws_subnet[each.value.subnet4].subnet_id ]
    tags                          = each.value.tags
}

module "aws_eks_node_group" {

   source = "./modules/aws_eks_nodegroup"
  
   for_each = var.eks_node_group_config

    node_group_name               = each.value.node_group_name
    eks_cluster_name              = module.aws_eks_cluster[each.value.eks_cluster_name].eks_cluster_name
    subnet_ids                    = [module.aws_subnet[each.value.private_subnet1].subnet_id,module.aws_subnet[each.value.private_subnet2].subnet_id]
    nodes_iam_role                = each.value.nodes_iam_role
    tags                          = each.value.tags
}



