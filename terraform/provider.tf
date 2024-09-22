provider "aws" {
region = "us-east-1"
}

provider "ansible" {
source = "ansible/ansible"
version = "1.1.0"
}
