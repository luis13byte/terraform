#
# Variables de salida

output "show_vpc_id" {
  sensitive   = true
  description = "The ID of the VPC"
  value       = concat(data.aws_vpc.selected.*.id, [""])[0]
}

output "show_aws_region_az" {
  sensitive = true
  value     = var.aws_region_az
}

output "show_client_cidr_block" {
  sensitive = true
  value     = local.client_cidr_block
}
