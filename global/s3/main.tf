terraform {
  backend "s3" {
    bucket = "remote-state-tfuar"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
# bucket name must be globally unique
    bucket = "${var.bucket_name}"

    versioning {
        enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }
}



/*

Setup remote S3 bucket to store remote state

terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}

*/