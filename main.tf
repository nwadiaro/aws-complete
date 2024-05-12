data "aws_key_pair" "my_key_pair" {
  key_name = "kenneth_key"
}

resource "aws_instance" "web" {
  ami           = "ami-051f8a213df8bc089"
  instance_type = "t2.micro"

  key_name                    = "kenneth_key"
  vpc_security_group_ids      = [aws_security_group.SG.id]
  user_data                   = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install httpd -y
              systemctl enable httpd
              systemctl start httpd
              EOF
  user_data_replace_on_change = true

  tags = {
    Name = "server"
  }
}

resource "aws_security_group" "SG" {
  name = "Terraform-Webserver-SG"

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }



  ingress {
    description = "Allow HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   
   ingress {
    description = "Allow HTTP"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}



# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
















  