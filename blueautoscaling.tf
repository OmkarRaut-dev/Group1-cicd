data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["398649119307"]

   filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter{
    name = "name"
    values = ["AMI-BUILD-Blue-*"]
  }
}

#autoscaling launch configuration
resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.small"
}

#auto sacaling group
resource "aws_autoscaling_group" "bar" {
  name                      = "foobar3-terraform-test"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.as_conf.name
  vpc_zone_identifier       = ["subnet-035d7231521e34dbd"]
  #availability_zones        = "eu-west-1a"
    tag {
    key                 = "name"
    value               = "custom blue instance"
    propagate_at_launch = true
  }
}

#aws_autoscaling_policy
resource "aws_autoscaling_policy" "custom_policy" {
  name                   = "custom_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.bar.name
  policy_type = "SimpleScaling"
}


