variable "access_key" {
  
}

variable "secret_key" {
  
}

data "aws_route53_zone" "name" {
  name = local.domain
}

provider "aws" {
  region = "eu-central-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

locals {
  domain = "appstellar.training"

}
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = "nderim.${local.domain}"
  zone_id      = data.aws_route53_zone.name.zone_id

  wait_for_validation = true

  tags = {
    Name = "my-domain.com"
  }
}

# output "certificate_arn" {
#     value = module.acm.acm_certificate_arn
# }