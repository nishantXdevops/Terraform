output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = values(aws_subnet.private)[*].id
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster API endpoint"
  value       = aws_eks_cluster.eks.endpoint
}

output "eks_node_group_name" {
  description = "Name of the node group"
  value       = aws_eks_node_group.default.node_group_name
}

output "eks_cluster_role_arn" {
  description = "ARN of the EKS cluster role"
  value       = aws_iam_role.eks_role.arn
}

output "eks_node_role_arn" {
  description = "ARN of the EKS node role"
  value       = aws_iam_role.node_role.arn
}
