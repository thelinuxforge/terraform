variable "vpcname" {
    type = string
    default = "myvpc"
    description = "Name of the vpc"
}

variable "sshport" {
    type = number
    default = 22
}

variable "enabled" {
  default = true
  type = bool
}

variable "mylist" {
  type = list(string)
  default = [ "value1", "value2" ]
}

variable "mymap" {
    type = map
    default = {
      "key1" = "value1"
      "key2" = "value2"
    }
}

variable inputname {
  type = string
  description = "Name of the vpc"
  default = "myvpc"
}


variable "mytuple" {
  type = tuple(string, number, string)
  default = ["cat", 1, "dog"]
  
}
  
variable "myobject" {
  type = object({ name = string, port = list(number) 
  })
  default = {
    name = "value1",
    port = [ 1, 1, 2 ]
  }
  }  




