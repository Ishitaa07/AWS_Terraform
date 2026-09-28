output "formatted_project_name" {
  value = replace(lower(local.project_name), " ", "-")
}

output "merged_tags" {
  value = local.tags
}

output "port_list" {
  value = local.port_list
}

output "sg_rules" {
  value = local.sg_rules
}

output "instance_sizes" {
  value = local.instance_sizes
}

output "credentials" {
  value = var.credentials
  sensitive = true
}

output "all_locations" {
  value = local.all_locations
}

output "unique_location" {
  value = local.unique_location
}

output "positive_costs" {
  value = local.positive_costs
}

output "max_cost" {
  value = local.max_cost
}

output "min_cost" {
  value = local.min_cost
}

output "total_cost" {
  value = local.total_cost
}

output "avg_cost" {
  value = local.avg_cost
}

output "current_timestamp" {
  value = local.current_timestamp
}

output "timestamp_name" {
  value = local.timestamp_name
}