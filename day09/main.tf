#Project Naming & Resource Tagging & Security Group Ports & Environment Lookup
locals {
  project_name = "Project ALPHA Resource"
  tags = merge(var.default_tags, var.environment_tags)
  formatted_bucket_name = replace(replace(substr(lower(var.bucket_name), 0, 63), " ", ""), "!", "")
  
  port_list = split(",", var.allowed_ports)

  sg_rules = [ for port in local.port_list :
  {
    name = "port-${port}"
    port = port
    description = "Allowed traffic on port ${port}"
  }
  ]

  instance_sizes = lookup(var.instance_sizes, var.environment, "t2.micro")
  all_locations = concat(var.user_location, var.default_location)
  unique_location = toset(local.all_locations)

  positive_costs = [for cost in var.monthly_costs : abs(cost)]
  max_cost = max(local.positive_costs...)
  min_cost = min(local.positive_costs...)
  total_cost = sum(local.positive_costs)
  avg_cost = local.total_cost / length(local.positive_costs)

  current_timestamp = timestamp()
  format1 = formatdate("yyyyMMdd", local.current_timestamp)
  format2 = formatdate("YYYYMMDD", local.current_timestamp)
  timestamp_name = "backup-${local.format1}"

  

}

#S3BucketNaming
resource "aws_s3_bucket" "example" {
  bucket = local.formatted_bucket_name
  tags = local.tags
 
}




