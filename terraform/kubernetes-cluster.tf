#kubernetes-cluster

# VPC Data - Use default VPC
data "aws_vpc" "default" {
  default = true
}

# Subnets Data - Get all subnets in the default VPC
data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# EKS Module Configuration
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"  # EKS version

  # VPC and Subnet configuration
  vpc_id                   = data.aws_vpc.default.id
  subnet_ids               = data.aws_subnets.default_subnets.ids
  control_plane_subnet_ids  = data.aws_subnets.default_subnets.ids

  # Enable public access to the EKS cluster endpoint
  cluster_endpoint_public_access = true

  # Cluster Add-ons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.small", "t3.micro", "t2.small"]
  }

  eks_managed_node_groups = {
    flixtube_nodes = {
      ami_type       = "AL2023_x86_64_STANDARD"  # AMI type
      instance_types = ["t2.small"]              # Instance type

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }

  # Add cluster creator as administrator
  enable_cluster_creator_admin_permissions = true

}

# Output EKS cluster name
output "eks_cluster_name" {
  description = "flixtube-cluster"
  value       = module.eks.cluster_id
}

# Output EKS node group name
output "eks_node_group_name" {
  description = "flixtube-nodes"
  value       = module.eks.eks_managed_node_groups
}
