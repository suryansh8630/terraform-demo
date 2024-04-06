
provider "aws" {
  region = "us-east-1" 
}

variable "instance_type" {
  default = "t2.micro" 
}

variable "ami" {
  default = "ami-0c55b159cbfafe1f0"
}

resource "aws_security_group" "example" {
  name        = "security-group"
  description = "Security Group"
  
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

# Create EC2 instance
resource "aws_instance" "example" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.example.name] #
  
  tags = {
    Name = "Instance"
  }
}
