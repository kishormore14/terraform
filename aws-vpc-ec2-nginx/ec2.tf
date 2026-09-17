resource "aws_instance" "NginxServer" {
  ami = "ami-098f18a6382fb4b2d"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.my-public-subnet_for_my-vpc.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  user_data_replace_on_change = true
  user_data = <<EOF
#!/bin/bash
# Force Nginx auto-install rebuild
sudo yum update -y
if command -v dnf &> /dev/null; then
    sudo dnf install -y nginx
elif command -v amazon-linux-extras &> /dev/null; then
    sudo amazon-linux-extras install -y nginx1
else
    sudo yum install -y nginx
fi
sudo systemctl start nginx
sudo systemctl enable nginx
EOF
  tags = {
    Name = "Nginx-Server"
  }
}