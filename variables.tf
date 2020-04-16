variable "region" {
  }

variable "instance_type" {
  }

variable "amitype" {
    }

variable "az" {
  type = "list"
  default = ["us-east-2a", "us-east-2b", "us-east-2c", "us-east-2d"]
    }

variable "sgs" {
    }

variable "private_key" {
    }

variable "vpc_cidr_block" {
    }

variable "vpc_name" {
    }

variable "pub_sub1_cidr" {
  }

variable "pub_sub2_cidr" {
    }

variable "pri_sub1_cidr" {
      }

variable "pri_sub2_cidr" {
        }
variable "pub_sub_name" {
  }

variable "pri_sub_name" {
    }

variable "igname" {
  }

variable "ngw" {
  }

variable "route_cidr" {
  }

variable "public_route_name" {
  }

variable "private_route_name" {
  }
