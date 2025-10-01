variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}
variable "public_subnet_az" {
  description = "Availability Zone for the public subnet."
  type        = string
  default     = "us-east-1a"
}

variable "private_subnet_az" {
  description = "Availability Zone for the private subnet."
  type        = string
  default     = "us-east-1b"
}