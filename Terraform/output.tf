output "vm_name" {
    description = "The name of the web server instance"
    value = aws_instance.web.Name 
}
output "public_ip" {
    description = "IP address of the web server instance"
    value       = aws_instance.web.public_ip
}