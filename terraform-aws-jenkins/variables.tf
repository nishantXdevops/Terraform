variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "key_name"{
    type = string
    default = "nishant-hp-key"
}

variable "ami_id"{
    type = string
    default = "ami-0129865974a10c1cb"
}

variable "instance_name"{
    type = string
    default = "testing"
}

variable "region" {
    type = string
    default = "us-east-1"
}