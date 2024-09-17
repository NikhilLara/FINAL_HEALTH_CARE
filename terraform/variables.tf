variable "vpc_cidr_block" {
    type = string
    description = "vpc default cidr_block"
    default = "10.0.0.0/16"
}

variable "healthcare_key" {
    type = string
    description = "Name of the AWS key pair"
    default = "healthcare"
}

variable "ami_id" {
    type = string
    description = "The AMI ID for Ubuntu Instance"
    default = "ami-0e86e20dae9224db8" 
}

variable "worker_nodes_count" {
    type = string
    description = "Total Number of Nodes"
    default = "2" 
}
