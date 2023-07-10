resource "aws_instance" "pkd_ec2" {
  # ami           = "ami-0c94855ba95c574c8"
  instance_type = "t2.micro"
  
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              EOF
}
