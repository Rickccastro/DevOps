variable "region" {
    description = "The AWS region to deploy resources in."
    type        = string
    default     = "us-east-1"  
}

variable "access_key" {
    description = "The AWS access key."
    type        = string    
    default     = "my-access-key"
  
}
variable "secret_key" {
    description = "The AWS secret key."
    type        = string    
    default     = "my-access-key"
}