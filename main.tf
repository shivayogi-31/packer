provider "aws" {

region = var.region

}



resource "aws_launch_configuration" "demo" {
  
  image_id = var.latest_ami
  instance_type = var.instance_type

}


resource "aws_autoscaling_group" "demo" {
  
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  launch_configuration = aws_launch_configuration.demo.id
  vpc_zone_identifier = var.subnet_ids
  
}
