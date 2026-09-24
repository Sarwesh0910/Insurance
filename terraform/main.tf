provider "aws" {
  region = var.region
}

resource "aws_vpc" "insurance_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.insurance_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.insurance_vpc.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_eks_cluster" "insurance_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_1.id,
      aws_subnet.subnet_2.id
    ]
  }
}

resource "aws_iam_role" "eks_role" {
  name = "insurance-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "eks.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })
}
