provider "aws" {
  region = "us-east-1"
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
  user_data = "${data.template_cloudinit_config.opsmi_cloud_init.rendered}"
  key_name = "instance-key"

  tags = {
    Name = "s3copy"
  }
}
data "template_file" "user_data" {
  template = "${file("${path.module}/user_data_template.tpl")}"
}

data "template_cloudinit_config" "opsmi_cloud_init" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.user_data.rendered}"
  }
}