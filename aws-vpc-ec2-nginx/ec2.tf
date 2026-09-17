resource "aws_instance" "NginxServer" {
  ami = "ami-098f18a6382fb4b2d"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.my-public-subnet_for_my-vpc.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  user_data_replace_on_change = true
  user_data = templatefile("${path.module}/templates/cloud-init.yml.tftpl", {})
  tags = {
    Name = "Nginx-Server"
  }
}