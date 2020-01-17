
variable "zone_id" {
  type = string
  description = "Route53 zone id to place records into"
}

variable "domain_name" {
  type = string
  description = "domain name to deploy static site to"
}

variable "origin_id" {
  type = string
  description = "Origin ID to give the CloudFlare origin"
}

variable "bucket_name" {
  type = string
  description = "Name of the S3 bucket to create"
}

variable "tags" {
	type = map(string)
	description = "Tags to apply to resources"
}
