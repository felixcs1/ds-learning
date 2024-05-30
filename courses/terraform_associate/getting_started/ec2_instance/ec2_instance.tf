locals {
  ami = "ami-0780837dd83465d73"
  timestamp = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

# resource "aws_s3_bucket" "example" {
#   bucket = "my-bucket-1h2h3j4k5k5k6k6j9s9ffdgjgdfklhdfgdfgd"
# }


# data "aws_ami" "amazon_linux_2" {
#   most_recent = true

#   filter {
#     name   = "owner-alias"
#     values = ["amazon"]
#   }

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm*"]
#   }

# }

resource "aws_instance" "app_server" {

    for_each = {
      "nano" = "t2.nano",
      "micro" = "t2.micro",
    }
    
    ami           = local.ami
    instance_type = each.value

    key_name               = aws_key_pair.gen_key_pair.key_name
    vpc_security_group_ids = [aws_security_group.renamed_security_group.id]


    user_data = "${file("scripts/setup.sh")}"

    tags = {
      Name = "Server-${each.key}"
    }

    # depends_on = [ aws_s3_bucket.example ]
    # run script on machine making tf apply command
    provisioner "local-exec" {
      working_dir = ".."
      command = "echo ${var.msg}"
    }

    lifecycle {
      prevent_destroy = false
    }
    # run script on machine provisioned
    # provisioner "remote-exec" {
    #   scripts = ["scripts/remote_exec.sh"]

    #   connection {
    #     type = "ssh"
    #     user = "ec2-user"
    #     private_key = tls_private_key.gen_tls_pk.private_key_pem
    #     host = self.public_dns
    #   }
    # }
    # copy files (takes a while)
    # provisioner "file" {
    #   source = "../getting_started"
    #   destination = "my_code"

    #   connection {
    #     type = "ssh"
    #     user = "ec2-user"
    #     private_key = tls_private_key.gen_tls_pk.private_key_pem
    #     host = self.public_dns
    #   }
  }



# Automatically generated key 'gen_tls_pk':
resource "tls_private_key" "gen_tls_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Automatically generated key_pair 'gen_key_pair':
resource "aws_key_pair" "gen_key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.gen_tls_pk.public_key_openssh
}

# Saves a local file
resource "local_file" "gen_key_pair" {
  content  = tls_private_key.gen_tls_pk.private_key_pem
  filename = var.key_file
}

resource "aws_security_group" "renamed_security_group" {
  name  = "extl-secgroup"

  # Enable ssh external server connection:
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  dynamic "egress" {
    for_each = var.egress_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# Waits for status checks takes longer
# resource "null_resource" "wait_for_instance_status_checks" {
#   provisioner "local-exec" {
#     command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.app_server.id} --profile personal"
#   }
#   depends_on = [aws_instance.app_server]
# }