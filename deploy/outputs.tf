output "bastion_host" {
  value = aws_instance.bastion.public_dns
}

output "db_host" {
  value = aws_db_instance.main.address
}
