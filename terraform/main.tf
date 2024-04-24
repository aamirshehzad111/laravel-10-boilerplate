module "eks" {
  source = "./modules/eks"

  cluster_name   = "eks-nnoscripta"
  vpc_subnet_ids = ["subnet-13ec6c59", "subnet-75accb0d"]
  vpc_id         = "vpc-01d4de79"

  eks_addons = {
    vpc_cni = {
      addon_name    = "vpc-cni"
      addon_version = "v1.17.1-eksbuild.1"
    },
    kube_proxy = {
      addon_name    = "kube-proxy"
      addon_version = "v1.29.1-eksbuild.2"
    },
  }

  node_groups = {
    node_group_1 = {
      node_group_name = "node-group-1"
      ami_type        = "AL2_x86_64"
      desired_size    = 1
      max_size        = 3
      min_size        = 1
      ec2_ssh_key     = "eks-key-pair"
      subnet_ids      = ["subnet-13ec6c59", "subnet-75accb0d"]
    },
    node_group_2 = {
      node_group_name = "node-group-2"
      ami_type        = "AL2_x86_64"
      desired_size    = 1
      max_size        = 3
      min_size        = 1
      ec2_ssh_key     = "eks-key-pair"
      subnet_ids      = ["subnet-13ec6c59", "subnet-75accb0d"]
    }

  }
}


output "eks_cluster_details_from_module" {
  value = module.eks.outputs
}




