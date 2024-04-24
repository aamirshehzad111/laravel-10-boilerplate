variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-nnoscripta"
}

variable "vpc_subnet_ids" {
  description = "List of subnet IDs for EKS cluster"
  type        = list(string)
  default     = ["subnet-13ec6c59", "subnet-75accb0d"]
}

variable "vpc_id" {
  description = "The VPC ID where resources will be created"
  type        = string
  default     = "vpc-01d4de79"
}
variable "eks_addons" {
  description = "EKS add-ons with their versions"
  type = map(object({
    addon_name    = string
    addon_version = string
  }))
  default = {
    vpc_cni = {
      addon_name    = "vpc-cni"
      addon_version = "v1.17.1-eksbuild.1"
    },
    kube_proxy = {
      addon_name    = "kube-proxy"
      addon_version = "v1.29.1-eksbuild.2"
    },
  }
}

variable "node_groups" {
  description = "Configuration for each EKS node group"
  type = map(object({
    node_group_name = string
    ami_type        = string
    desired_size    = number
    max_size        = number
    min_size        = number
    ec2_ssh_key     = string
    subnet_ids      = list(string)
  }))
  default = {
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
    # Add more node groups here as needed.
  }
}

variable "security_group_name" {
  description = "Name of the security group for EKS nodes."
  type        = string
  default     = "eks-nodes-sg"
}

variable "ingress_rules" {
  description = "List of ingress rules for the EKS nodes security group."
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "TCP"
      from_port   = 1025
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "egress_rules" {
  description = "List of egress rules for the EKS nodes security group."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}


