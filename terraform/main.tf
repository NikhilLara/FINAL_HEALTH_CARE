resource "aws_instance" "final-healthcare-server" {
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
  Name = "final-healthcare-server"
  }
provisioner "remote-exec" {
    inline = [
"sudo apt-get update -y",
"sudo apt-get install docker.io -y",
"sudo systemctl restart docker",
"docker run -itd -p 8084:8082 nikhillara1989/final_health_care:1.0"
"sudo apt-get update -y",
"sudo apt: pkg={{ item }} state=present",
"sudo apt-get install apt-transport-https -y",
"sudo apt-get install apt-ca-certificates -y",
"sudo apt-get install apt-curl -y",
"sudo apt-get install apt-ca-certificates -y",
“sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -”,
“sudo Add Kubernetes apt repository",
"sudo apt-get install deb https://apt.kubernetes.io/ kubernetes-xenial main -y",
"sudo apt-add repository distribution: xenial -y",
"sudo apt-add repository components: main -y",
"sudo apt add repository state: present -y",
“sudo apt: pkg={{ item }} state=present -y”,
"sudo apt-get install apt-kubectl -y",
"sudo apt-get install apt-kubelet -y",
"sudo apt-get install apt-kubeadm -y",
“Sudo shell: kubeadm init --pod-network-cidr=10.244.0.0/16”
"Join Kubernetes cluster (optional)",
 "shell: kubeadm join --token {{ output.stdout }} --discovery-token-ca-cert-hash {{ output.stdout }}",
 "when: inventory_hostname in groups['k8s_masters']",  # Assuming 'k8s_masters' group for master node
"sudo groupadd docker",
"sudo usermod -aG docker ubuntu", 
]
provisioner "local-exec" {
  command = "echo ${aws_instance.final-healthcare-server.public_ip} > inventory"
  }
provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/Finance/terraform/ansibleplaybook.yml"
  }
}
