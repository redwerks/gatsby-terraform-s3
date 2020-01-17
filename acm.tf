
resource "aws_acm_certificate" "cert" {
  provider                  = aws.global
  domain_name               = local.domain_name
  subject_alternative_names = [local.www_domain_name]
  validation_method         = "DNS"
  tags = merge(var.tags, {
    Name    = var.origin_id
  })
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation_record" {
  provider = aws.global
  for_each = { for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.resource_record_name => dvo }
  zone_id  = var.zone_id
  name     = each.value.resource_record_name
  type     = each.value.resource_record_type
  records  = [each.value.resource_record_value]
  ttl      = 300
}

resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.global
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = values(aws_route53_record.cert_validation_record)[*].fqdn
}
