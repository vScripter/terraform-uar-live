# Notes

When using "Data" resources, you have to ensure that the data that is being queried fr, actually exists. Example: when calling the `module "webserver_cluster"{}` it, in turn calls `data "terraform_remote_state" "db" {}` within `/modules/services/webserver-cluster/main.tf`. Even though everything is parameterized, there is a dependency that data actually exists when fetching the remote state. In the book, there was an assumption that it exists from previous examples, but if it did not, or `terraform destroy` was ran, at the end of each chapter, you will need to actually `apply` the configuration defined in `/stage/data-stores/mysql` which is where data is being fetched from when calling `data "terraform_remote_state" "db" {}`

Remote State doesn't work as the code suggests, at the time the book was written. I had to add the following at the top of the appropriate file and adjust, accordingly.
```hcl
terraform {
  backend "s3" {
    bucket = "remote-state-tfuar"
    key    = "/path/to/terraform.tfstate"
    region = "us-east-1"
  }
}
```