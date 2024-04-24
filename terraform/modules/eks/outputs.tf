output "outputs" {
  description = "Details of the EKS cluster"
  value = {
    cluster_arn       = try(aws_eks_cluster.eks.arn, null),
    cluster_endpoint  = try(aws_eks_cluster.eks.endpoint, null),
    cluster_id        = try(aws_eks_cluster.eks.cluster_id, ""),
    cluster_name      = try(aws_eks_cluster.eks.name, "")
  }
}
