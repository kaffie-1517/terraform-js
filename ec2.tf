#key pair (login)

resource "aws_key_pair" "my-key" {

  key_name   = "fitst-key"
  public_key = file("terra-key-ec2.pub")

}


#vpc and security grp

resource "aws_default_vpc" "default" {

} 

resource "aws_security_group" "my-sec-grp" {

  name        = "automate-sg"
  description = "this is a sg"
  vpc_id      = aws_default_vpc.default.id #interpolation

  # inbound rules

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "nginx open"
  }

  # outbound rules

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" #allow all ports
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all access outbound"
  }

  tags = {
    Name = "automate-sg"
  }

}



resource "aws_instance" "my-instance" {
  
  
  key_name        = aws_key_pair.my-key.key_name
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.my-sec-grp.name]
  ami             = var.ec2_ami_id
  
 

  user_data = file("jass.sh")

  root_block_device {
    volume_size = var.ec2_root_storage_size
    volume_type = "gp2"
  }

  

  tags = {
    Name = "first_iac"
  }

}