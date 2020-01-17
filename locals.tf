
locals {
  domain_name     = var.domain_name
  www_domain_name = "www.${local.domain_name}"
}
