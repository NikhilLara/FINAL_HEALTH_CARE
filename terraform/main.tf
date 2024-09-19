resource "aws_instance" "final-healthcare-server-K8S-MASTER" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.medium"
  key_name      = "keypair2"
  vpc_security_group_ids = ["sg-0624c6a8b6420566d"]

 provisioner "remote-exec" {
    inline = [ 
      "sudo apt update -y",
      "sudo apt install ansible -y"
     ]
  }

  connection {
    type        = "ssh"
    user       = "ubuntu"
    private_key = file("./keypair2.pem")
    host        = self.public_ip
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 14
  }

  tags = {
    Name     = "final-healthcare-server-K8S-MASTER"
    Role     = "control plane node"
  }

  provisioner "local-exec" {
    command = "echo 'master ${self.public_ip}' >> ./files/hosts"
  }
}

resource "aws_instance" "final-healthcare-server-K8S-worker-node" {
  count = 2

  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  key_name      = "keypair2"
  vpc_security_group_ids = ["sg-0624c6a8b6420566d"]

  connection {
    type        = "ssh"
    user       = "ubuntu"
    private_key = file("./keypair2.pem")
    host        = self.public_ip
  }

  tags = {
    Name     = "final-healthcare-server-K8S-worker-node ${count.index}"
    Role     = "worker node"
  }

  provisioner "local-exec" {
    command = "echo 'worker-${count.index} ${self.public_ip}' >> ./files/hosts"
  }
  provisioner "remote-exec" {
    inline = ["ansible-playbook /var/lib/jenkins/workspace/Finance/terraform/ansibleplaybook.yml"]
  }
}
