provider "aws" {
  region = "us-east-1"
}

locals {
  instance_user_data = {
    write_files = [
      {
        encoding = "b64"
        permissions = "0754"
        content  = filebase64("${path.module}/s3copy.sh")
        path     = "/tmp/s3copy.sh"
      },
      {
        owner = "root:root"
        content  = "*/5 * * * * root /tmp/s3copy.sh"
        path     = "/etc/cron.d/s3copy_cron"
      }
    ]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data = <<-EOT
  #cloud-config
  ${yamlencode(local.instance_user_data)}
  EOT
  key_name = "instance-key"

  tags = {
    Name = "HelloWorld"
  }
}