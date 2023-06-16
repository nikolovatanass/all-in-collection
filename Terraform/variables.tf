variable "aws_region" {
  type = string
  description = "Region for AWS resources to be created"
  default = "eu-west-1"
}

variable "vpc" {
    type = string
    description = "VPC for AWS resources to use"
    default = "10.0.3.0/24"
  
}

variable "subnet1" {
    type = string
    description = "Subnet1"
    default = "10.0.3.0/25"
  
}

variable "route" {
    type = string
    description = "Default route"
    default = "0.0.0.0/0"
  
}

variable "instance_type" {
    type = string
    description = "Type of instance we use"
    default = "t2.micro"
    
}

variable "company" {
    type = string
    description = "Company name for resource tagging"
    default = "OriginalCompanyName"
  
}

variable "project" {
    type = string
    description = "Adding project to tag resources"
    default = "OriginalProjectName"
  
}