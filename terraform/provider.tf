provider "aws" {
region = "us-east-1"
}

required_providers {
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
