terraform {
  backend "s3" {
    bucket = "remote-state-tfuar"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  #cluster_name           = "webservers-stage"
  #db_remote_state_bucket = "${var.db_remote_state_bucket}"
  #db_remote_state_key    = "${var.db_remote_state_key}"

  cluster_name           = "webservers-stage"
  db_remote_state_bucket = "remote-state-tfuar"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = "${module.webserver_cluster.elb_security_group_id}"

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}