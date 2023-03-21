
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region"
}

variable "profile" {
  type    = string
  default = "default"
}


variable "ami_id" {
  type        = string
  default     = "ami-09cd747c78a9add63"
}


variable "instance_type" {
  type        = string
  default     = "t2.micro"
}


variable "key_name" {
  type        = string
  default     = "test-kp"
}


variable "root_volume_size" {
  type        = string
  default     = "20"
}


variable "root_volume_type" {
  type        = string
  default     = "gp3"
}



variable "alb_name" {
  type        = string
  default     = "pearl-alb"
}

