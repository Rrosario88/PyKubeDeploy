resource "aws_instance" "pkd_ec2" {
  ami           = "ami-09cd431658b5ab3be"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0ed2ed10a337623af"
  key_name      = "PyKubeKeys"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ubuntu
              # Copy the update_inventory.sh script to the EC2 instance
              curl -o /tmp/update_inventory.sh https://example.com/update_inventory.sh
              # Make the script executable
              sudo chmod +x /tmp/update_inventory.sh
              # Run the script
              /tmp/update_inventory.sh
              EOF
            


  provisioner "local-exec" {
    command = "update_inventory.sh"

  }
  tags = {
    name = "PyKubeDeploy"
  }
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