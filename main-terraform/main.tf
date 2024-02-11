
# Create a new VPC
resource "aws_vpc" "pkd_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "pkd_VPC"
  }
}

# Create a subnet within the new VPC
resource "aws_subnet" "pkd_subnet" {
  vpc_id            = aws_vpc.pkd_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "pkd_subnet"
  }
}

# Create a security group within the new VPC
resource "aws_security_group" "pkd_security_group" {
  vpc_id = aws_vpc.pkd_vpc.id

  tags = {
    Name = "pkd_security_group"
  }
}

# Modify your EC2 instance to use the new subnet and security group
resource "aws_instance" "pkd_ec2" {
  ami           = "ami-05548f9cecf47b442"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.pkd_subnet.id
  key_name      = "CastleKeys"
  vpc_security_group_ids = [aws_security_group.pkd_security_group.id]

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
    Name = "PyKubeDeploy"
  }
}

# Create an Internet Gateway for your VPC
resource "aws_internet_gateway" "pkd_gateway" {
  vpc_id = aws_vpc.pkd_vpc.id

  tags = {
    Name = "pkd_gateway"
  }
}

# Create a custom route table for your VPC
resource "aws_route_table" "pkd_route_table" {
  vpc_id = aws_vpc.pkd_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pkd_gateway.id
  }

  tags = {
    Name = "pkd_route"
  }
}

# Associate the route table with your subnet
resource "aws_route_table_association" "pkd_route_association" {
  subnet_id      = aws_subnet.pkd_subnet.id
  route_table_id = aws_route_table.pkd_route_table.id
}


# Key pair remains unchanged
resource "aws_key_pair" "CastleKeys" {
  key_name   = "CastleKeys"
  public_key = file("~/.ssh/CastleKeys.pub")
}

# Modify security group rules to reference the new security group
resource "aws_security_group_rule" "allow_inbound" {
  security_group_id = aws_security_group.pkd_security_group.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_inbound_5000" {
  security_group_id = aws_security_group.pkd_security_group.id
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_inbound_8080" {
  security_group_id = aws_security_group.pkd_security_group.id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group" "allow_outgoing_internet" {
  name        = "allow_outgoing_internet"
  description = "Allow outgoing internet access"
  vpc_id      = aws_vpc.pkd_vpc.id  # Replace with your VPC ID

  # Outbound rule - Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AllowOutgoingInternet"
  }
}






/*
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
*/
