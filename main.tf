resource "aws_instance" "pkd_ec2" {
  ami           = "ami-00abfd8da690f984d"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0ed2ed10a337623af"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              EOF
}
