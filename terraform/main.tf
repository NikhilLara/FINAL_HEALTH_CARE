
resource "aws_instance" "final-banking-server" {
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
  Name = "final-banking-server"
  }
provisioner "local-exec" {
  command = "echo ${aws_instance.final-banking-server.public_ip} > inventory"
  }
provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/FINAL_BANKING_PROJECT/terraform/ansibleplaybook.yml"
  }
}
