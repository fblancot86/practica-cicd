terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

variable "prod_deploy" {
    description = "If set to true, enable Prod deployment"
    type = bool
    default = false
}

resource "aws_s3_bucket" "dev" {
  bucket = "acme-storage-dev-${random_string.texto.result}"

  tags = {
    Name        = "My Develompment bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "dev_private" {
  bucket = aws_s3_bucket.dev.id
  acl    = "private"
}

resource "aws_s3_bucket" "prod" {
    count = var.prod_deploy ? 1 : 0

    bucket = "acme-storage-prod-${random_string.texto.result}"

    tags = {
        Name        = "My Production bucket"
        Environment = "Prod"
    }
}

resource "aws_s3_bucket_acl" "prod_private" {
    count = var.prod_deploy ? 1 : 0

    bucket = aws_s3_bucket.prod[0].id
    acl    = "private"
}


resource "random_string" "texto" {
    length = 4
    special = false
    upper = false
}
