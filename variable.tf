variable "region" {
    default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "latest_ami" {
  description = "The ID of the latest AMI"
}

variable "subnet_ids" {
  type        = list(string)
   default     = ["subnet-00cc3ed577853a9ce"] 
}



