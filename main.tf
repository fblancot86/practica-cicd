terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

variable "env" {
  default = "dev"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "acme-storage-${var.env}-${random_string.texto.result}"

  tags = {
    Name        = "My bucket"
    Environment = var.env
  }
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "random_string" "texto" {
    length = 4
    special = false
    upper = false
}
