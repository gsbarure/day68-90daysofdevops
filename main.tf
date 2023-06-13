resource "aws_launch_configuration" "web_server_as" {
  image_id        = "ami-04a0ae173da5807d3"
  instance_type  = "t2.micro"
  security_groups = [aws_security_group.web_server.id]

  user_data = filebase64("userdata.sh")
}

resource "aws_autoscaling_group" "web_server_asg" {
  name                 = "web-server-asg"
  launch_configuration = aws_launch_configuration.web_server_as.name
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  health_check_type    = "EC2"
  vpc_zone_identifier  = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]
}
