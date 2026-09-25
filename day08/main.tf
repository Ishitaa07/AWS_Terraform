resource "aws_instance" "example" {
  ami           = "ami-0ff8a91507f77f867"
  count = var.instance_count
  instance_type = var.environment == "dev" ? "t3.micro" : "t3.small"

  tags = var.tags
}


resource "aws_security_group" "example" {
  name   = "sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_block
      protocol = ingress.value.protocol
    }
  }


  egress  = []
}

locals {
  aws_all_instances = aws_instance.example[*].id
}

output  "instances" {
  value = local.aws_all_instances
}