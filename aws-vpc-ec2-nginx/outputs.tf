output "Nginx-Server-Public-IP" {
  value = aws_instance.NginxServer.public_ip
}

output "Nginx-Server-Public-DNS" {
  value = aws_instance.NginxServer.public_dns
}

output "nginx-sg-id" {
  value = aws_security_group.nginx-sg.id
}

output "VPC-ID" {
  value = aws_vpc.my-vpc.id
}

output "public-subnet-id" {
  value = aws_subnet.my-public-subnet_for_my-vpc.id
}

output "private-subnet-id" {
  value = aws_subnet.my-private-subnet_for_my-vpc.id
}
output "Instance_URL" {
  value = "http://${aws_instance.NginxServer.public_ip}"
}