provider "aws" {

region = "ap-south-1"

}



resource "aws_launch_configuration" "demo" {
  
  image_id = var.image_id
  instance_type = var.instance_type
  security_groups = [""]
  key_name = "new-kp"
}


resource "aws_autoscaling_group" "demo" {
  
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  launch_configuration = aws_launch_configuration.demo.id
  vpc_zone_identifier  = ["subnet-"] 

}
