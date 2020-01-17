
resource "aws_route53_record" "root" {
  zone_id = var.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.site_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.site_cdn.hosted_zone_id
  }
}

resource "aws_route53_record" "root6" {
  zone_id = var.zone_id
  name    = local.domain_name
  type    = "AAAA"

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.site_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.site_cdn.hosted_zone_id
  }
}

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = local.www_domain_name
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.site_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.site_cdn.hosted_zone_id
  }
}

resource "aws_route53_record" "www6" {
  zone_id = var.zone_id
  name    = local.www_domain_name
  type    = "AAAA"

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.site_cdn.domain_name
    zone_id                = aws_cloudfront_distribution.site_cdn.hosted_zone_id
  }
}
