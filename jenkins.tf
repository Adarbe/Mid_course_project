locals {
  jenkins_default_name = "jenkins"
  jenkins_home = "/home/ubuntu/jenkins_home"
  jenkins_home_mount = "${local.jenkins_home}:/var/jenkins_home"
  docker_sock_mount = "/var/run/docker.sock:/var/run/docker.sock"
  java_opts = "JAVA_OPTS='-Djenkins.install.runSetupWizard=false'"
  jenkins_master_url = "http://${aws_instance.jenkins_master.public_ip}:8080"

}




resource "aws_key_pair" "jenkins_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = file("jenkins_ec2_key.pub")
}

resource "aws_instance" "jenkins_master" {
  ami = "ami-07d0cf3af28718ef8"
  instance_type = "t3.micro"
  key_name = aws_key_pair.jenkins_ec2_key.key_name
  tags = {
    Name = "Jenkins Master"
  }
  security_groups = ["default", aws_security_group.jenkins.name]
  connection {
    host = aws_instance.jenkins_master.public_ip
    user = "ubuntu"
    private_key = file("jenkins_ec2_key")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt install docker.io -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ubuntu",
      "mkdir -p ${local.jenkins_home}",
      "sudo chown -R 1000:1000 ${local.jenkins_home}",
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "sudo docker run -d -p 8080:8080 -p 50000:50000 -v ${local.jenkins_home_mount} -v ${local.docker_sock_mount} --env ${local.java_opts} jenkins/jenkins"
   ]
  }
}



resource "aws_instance" "jenkins_slave" {
# description = "create 2 EC2 machines for jenkins slave"
  count = 2
  ami = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
  key_name = aws_key_pair.jenkins_ec2_key.key_name
  tags = {
    Name = "jenkins_slave ${count.index}"
    Labels = "linux"
  }
  connection {
    type = "ssh"
    host = "self.public_ip"
    private_key = file("jenkins_ec2_key")
    user = "ec2-user"
  }
  #availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  security_groups = ["default", aws_security_group.jenkins.name]


     user_data = <<-EOF
            #! /bin/bash
            sudo yum update -y
            sudo yum install java-1.8.0 -y
            sudo alternatives --install /usr/bin/java java /usr/java/latest/bin/java 1 -y
            sudo yum install docker git -y
            sudo service docker start
            sudo usermod -aG docker ec2-user
            sudo chown -R jenkins:jenkins /var/lib/jenkins/

            sudo yum install epel-release -y
            sudo yum install python-pip -y
            sudo pip install awscli
            sudo yum install git -y
            sudo chmod 777 /var/lib/jenkins/
  EOF
  }