
resource "aws_instance" "ubuntu" {
#   name                        = "expressjs-app"
  ami                         = var.ami_id                                          # "ami-09cd747c78a9add63"
  instance_type               = var.instance_type                                   # "t2.micro"
  associate_public_ip_address = true
  key_name                    = var.key_name                                         # "test-kp" 
  vpc_security_group_ids      = [aws_security_group.allow_word.id]            
  subnet_id                   = aws_subnet.pearl-pub-1a.id                          # var.subnets_id
  iam_instance_profile        = aws_iam_instance_profile.profile.name
  # root disk
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
    # encrypted             = true
  }

  tags = {
    Name = "expressjs-app"
    } 

}



resource "aws_instance" "jenkins" {
#   name                        = "expressjs-app"
  ami                         = var.ami_id                                          # "ami-09cd747c78a9add63"
  instance_type               = var.instance_type                                   # "t2.micro"            
  associate_public_ip_address = true
  key_name                    = var.key_name                                         # "test-kp" 
  vpc_security_group_ids      = [aws_security_group.allow_word.id]            
  subnet_id                   = aws_subnet.pearl-pub-1b.id                          # var.subnets_id
  iam_instance_profile        = aws_iam_instance_profile.profile.name
  # root disk
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
    # encrypted             = true
  }

  tags = {
    Name = "jenkins-app"
    } 

}

