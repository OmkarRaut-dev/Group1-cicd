
data "aws_ami" "ubuntu1" {
  most_recent = true
  owners = ["222394667866"]

   filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter{
    name = "name"
    values = ["AMI-BUILD-Green-*"]
  }
}

#autoscaling launch configuration
resource "aws_launch_configuration" "as_conf1" {
  name          = "web_config1"
  image_id      = data.aws_ami.ubuntu1.id
  instance_type = "t3.small"
  
}


#auto sacaling group
resource "aws_autoscaling_group" "bar1" {
  name                      = "foobar3-terraform-test1"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.as_conf1.name
  vpc_zone_identifier       = ["subnet-0c1fa16423c46bf4d"]
    tag {
    key                 = "name"
    value               = "custom green instance"
    propagate_at_launch = true
  }
}

#aws_autoscaling_policy
resource "aws_autoscaling_policy" "custom_policy1" {
  name                   = "custom_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.bar1.name
  policy_type = "SimpleScaling"
}
