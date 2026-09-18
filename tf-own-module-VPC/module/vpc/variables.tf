variable "vpc_config" {
    type = object({
    cidr_block = string
    name       = string
  })
}

variable "subnet_config" {
  description = "Get the cidr and az"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}