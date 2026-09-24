output "cluster_name" {
  value = aws_eks_cluster.insurance_cluster.name
}

output "vpc_id" {
  value = aws_vpc.insurance_vpc.id
}
