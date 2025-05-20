variable "aws_region" {
  default     = "us-east-1"
  description = "aws region"
}

variable "cluster_name" {
  default     = "kiran-eks-demo"
  description = "name of the cluster"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "default CIDR range of the VPC"
}

variable "enable_monitoring_namespace" {
  description = "create monitoring namespace"
  type        = bool
  default     = false
}