terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.5.0"
    }
  }
}

variable "bucket_s3_env" {
    description = "Entorno del bucket"
    default = "dev"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "acme-storage-${var.bucket_s3_env}-${random_string.texto.result}"

  tags = {
    Name        = "My ${var.bucket_s3_env} bucket"
    Environment = "${var.bucket_s3_env}"
  }
}

resource "aws_s3_bucket_acl" "acl" {
    bucket = aws_s3_bucket.bucket.id
    acl    = "private"
}


resource "random_string" "texto" {
    length = 4
    special = false
    upper = false
}
