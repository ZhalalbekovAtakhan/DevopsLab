resource "tls_private_key" "lab-key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "lab-keypair" {
  key_name   = "lab-keypair"
  public_key = tls_private_key.lab-key.public_key_openssh
}

output "private_key_pem" {
  value = tls_private_key.lab-key.private_key_pem
  sensitive = true
}


resource "aws_instance" "lab_ec2_instance_1" {
  ami           = "ami-02278fe421e52439d"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.lab_subnet_1.id
  key_name      = aws_key_pair.lab-keypair.key_name
  vpc_security_group_ids = [aws_security_group.lab_security_group.id]

  tags = {
    Name = "lab-ec2-instance-1"
  }
}

resource "aws_instance" "my_ec2_instance_2" {
  ami           = "ami-02278fe421e52439d"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.lab_subnet_2.id
  key_name      = aws_key_pair.lab-keypair.key_name
  vpc_security_group_ids = [aws_security_group.lab_security_group.id]

  tags = {
    Name = "lab-ec2-instance-2"
  }
}