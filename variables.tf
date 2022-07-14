variable "access_key"{}
variable "secret_key" {}
variable "region" {
  type = string
}

 variable "cluster-name" {
  description = "EKS cluster name."
  default     = "demo-cluster"
  type        = string
}


variable "vpc_config" {
  
}

variable "subnet_config" {
  
}

variable "internet_gw_config" {
  
}
variable "elastic_ip_config" {
  
}

variable "aws_natGW_config" {
  
}

variable "aws_route_table_config" {
  
}

variable "route_table_association_config" {
  
}

variable "aws_eks_cluster_config" {
  
}
variable "eks_node_group_config" {
  
}

