module "vpc" {
    source = "../modules/vpc"
    cidr_block = "172.16.0.0/16"
}
