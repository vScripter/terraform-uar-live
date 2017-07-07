terraform {
  backend "s3" {
    bucket = "remote-state-tfuar"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database_stage"
  username            = "admin"
  password            = "${var.db_password}"
  skip_final_snapshot = true
}
