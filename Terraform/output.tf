output "vm_name" {
  description = "The name of the web server instance"
  value       = aws_instance.web.tags["Name"]
}
output "public_ip" {
  description = "IP address of the web server instance"
  value       = aws_instance.web.public_ip
}
output "private_key_pem" {
  value     = tls_private_key.main.private_key_pem
  sensitive = true
}