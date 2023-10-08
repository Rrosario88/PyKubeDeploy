resource "aws_instance" "pkd_ec2" {
  ami           = "ami-05548f9cecf47b442"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0ed2ed10a337623af"
  key_name      = "CastleKeys"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ubuntu
              EOF
            


  provisioner "local-exec" {
    command = "./update_inventory.sh"

  }
  tags = {
    name = "PyKubeDeploy"
  }
}

resource "aws_key_pair" "CastleKeys" {
  key_name   = "CastleKeys"
  public_key = file("~/.ssh/CastleKeys.pub")
}


resource "aws_security_group_rule" "allow_inbound" {
  security_group_id = "sg-08b6fecc9fde31932" # Replace with your security group ID
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_inbound_5000" {
  security_group_id = "sg-08b6fecc9fde31932" # Replace with your security group ID
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

