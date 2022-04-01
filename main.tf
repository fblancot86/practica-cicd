terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

resource "aws_s3_bucket" "dev" {
  bucket = "acme-storage-dev-${random_string.texto.result}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "prod" {
  bucket = "acme-storage-prod-${random_string.texto.result}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.dev.id
  acl    = "private"
}

resource "random_string" "texto" {
    length = 4
    special = false
    upper = false
}
