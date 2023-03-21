resource "aws_security_group" "allow_word" {
    name        = "allow_word"
    vpc_id     = aws_vpc.pearl-vpc.id

    ingress {
        from_port   = 0		
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "pearl-sg"
    }
  
}