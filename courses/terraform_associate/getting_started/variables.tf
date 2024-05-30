variable "example_map" {
  type = map
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

variable "example_list" {
  type = list
  default = ["value1", "value2"]
}

variable "example_object" {
  type = object({
    key1 = string
    key2 = string
  })
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

variable "example_set" {
  type = set(string)
  default = ["value1", "value2"]
}


variable "example_tuple" {
  type = tuple([string, string, bool])
  default = ["value1", "value2", true]
}