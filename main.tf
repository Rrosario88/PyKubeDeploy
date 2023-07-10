resource "aws_instance" "pkd_ec2" {
  ami           = "ami-09cd431658b5ab3be"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0ed2ed10a337623af"
  key_name   = "PyKubeDeployKey"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              EOF

  tags = {
    name = "PyKubeDeploy"
  }            
}
