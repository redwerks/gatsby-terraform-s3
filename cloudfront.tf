
resource "aws_cloudfront_distribution" "site_cdn" {
  origin {
    domain_name = aws_s3_bucket.site_bucket.website_endpoint
    origin_id   = var.origin_id

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  tags = var.tags

  enabled             = true
  wait_for_deployment = false
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  http_version        = "http2"
  comment             = local.domain_name

  aliases = [
    local.domain_name,
    local.www_domain_name,
  ]

  price_class = "PriceClass_All"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = var.origin_id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code         = "404"
    response_code      = "404"
    response_page_path = "/404.html"
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.cert_validation.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
