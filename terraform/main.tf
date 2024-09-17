resource "aws_instance" "final-healthcare-server-K8S-MASTER" {
ami = "ami-0e86e20dae9224db8"
instance_type = "t2.medium"
key_name = "keypair2"
vpc_security_group_ids = ["sg-0624c6a8b6420566d"]
connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("./keypair2.pem")
    host = self.public_ip
    }
provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance' "]
}
root_block_device {
    volume_type = "gp2"
    volume_size = 14
  }

  tags = {
    Name = "KUBERNETES-MAIN"
    Role = "control plane node"  
  }
provisioner "local-exec" {
    command = "echo 'master ${self.public_ip}' >> ./files/hosts" 
  }

resource "aws_instance" "final-healthcare-server-K8S-worker-node" {
count = var.worker_noud_count
ami = "ami-0e86e20dae9224db8"
instance_type = "t2.micro"
key_name = "keypair2"
vpc_security_group_ids = ["sg-0624c6a8b6420566d"]
connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("./keypair2.pem")
    host = self.public_ip
    }
provisioner "remote-exec" {
    inline = ["echo 'wait to start the instance' "]
}

tags = {
    Name = "KUBERNETES-worker-nodes ${count.index}" 
    Role = "control plane node"  
  }
provisioner "local-exec" {
    command = "echo 'worker-${count.index} ${self.public_ip}' >> ./files/hosts"
    
  }

provisioner "local-exec" {
  command = "echo ${aws_instance.final-healthcare-server1.public_ip} > inventory"
  }
provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/Finance/terraform/ansibleplaybook.yml"
  }
}
