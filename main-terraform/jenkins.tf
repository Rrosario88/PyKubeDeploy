
/*
resource "aws_instance" "jenkins" {
  ami           = "ami-05548f9cecf47b442" # Replace with the latest Amazon Linux AMI in your region
  instance_type = "t2.micro" # Adjust as per your requirements

  key_name               = "CastleKeys" # SSH Key name for EC2 instance
  vpc_security_group_ids = ["sg-08b6fecc9fde31932"] # Security group ID

  tags = {
    Name = "Jenkins"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install java-1.8.0-openjdk-devel -y
              
              # Install Jenkins
              wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
              yum upgrade
              yum install jenkins -y
              systemctl start jenkins
              systemctl enable jenkins

              # Install Docker
              yum install docker -y
              systemctl start docker
              systemctl enable docker
              usermod -a -G docker jenkins

              # Install Ansible
              yum install epel-release -y
              yum install ansible -y

              # Install Terraform
              wget https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip
              unzip terraform_1.0.0_linux_amd64.zip
              mv terraform /usr/local/bin/
              EOF

}

*/
