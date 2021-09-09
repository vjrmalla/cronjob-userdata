provider "aws" {
  region = "us-east-1"
  allowed_account_ids = ["571725821101"]
}

locals {
  instance_user_data = {
  "groups": [
    "infraopsmi"
  ],
  "users": [
    "default",
    {
      "name": "opsmicopy",
      "sudo": [
        "ALL=(ALL) NOPASSWD:ALL"
      ],
      "groups": "infraopsmi",
      "shell": "/bin/bash"
    }
  ],
  "write_files": [
    {
      "owner": "root:root",
      "path": "/opt/s3copy.sh",
      "permissions": "0754",
      "content": file("${path.module}/s3copy.sh")
    },
    {
      "owner": "root:root",
      "path": "/etc/crontab",
      "content": "*/5 * * * * root /opt/s3copy.sh\n",
      "append": "true"
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
    Name = "s3-copy-local"
  }
}