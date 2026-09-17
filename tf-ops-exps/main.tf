variable "num_list" {
    type = list(number)
    default = [ 1,2,3,4,5 ]
  
}
variable "person_list" {
    type = list(object({name = string, age = number}))
    default = [
        {name = "John", age = 30},
        {name = "Jane", age = 25},
        {name = "Bob", age = 35}
    ]
}
variable "person_map" {
    type = map(number)
    default = {
        "john" = 30,
        "jane" = 25,
        "bob" = 35
    }
}

# calculation
locals {
  mul=2*2
  sum=30+25+35
  string_interpolation= "Name:${var.person_list[0].name} and Age: ${var.person_list[0].age}"
}
output "num_list" {
    value = var.num_list
}
output "person_list" {
    value = var.person_list
}
output "person_map" {
    value = var.person_map
}
output "mul" {
  value = local.mul
}
output "sum" {
  value = local.sum
}
output "string_interpolation" {
  value = local.string_interpolation
}