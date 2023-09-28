variable "aws_access_key" {
  type    = string
  default = env("AWS_GH_ACCESS_KEY")
}

variable "aws_region" {
  type    = string
  default = env("AWS_REGION")
}

variable "aws_secret_key" {
  type    = string
  default = env("AWS_GH_ACCESS_VAL")
}

variable "share_account_id" {
  type    = list(string)
  default = [env("AWS_PG_DEMO_ACCOUNT_ID")]
}

variable "owner_account_id" {
  type    = list(string)
  default = [env("AWS_UK_DEMO_ACCOUNT_ID")]
}

variable "source_ami" {
  type    = string
  default = env("AWS_JENKINS_SOURCE_AMI")
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "subnet_id" {
  type    = string
  default = env("AWS_GH_DEV_SUBNET_ID")
}
# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "autogenerated_1" {
  access_key      = "${var.aws_access_key}"
  ami_description = "Ubuntu 22.04 AMI for CSYE 7125"
  ami_name        = "csye7125_${local.timestamp}"
  source_ami_filter {
    filters = {
      architecture        = "x86_64"
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  # ami_users       = "${var.share_account_id}"
  instance_type   = "t2.micro"
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    volume_size           = 8
    volume_type           = "gp2"
  }
  region       = "${var.aws_region}"
  secret_key   = "${var.aws_secret_key}"
  ssh_username = "${var.ssh_username}"
  subnet_id    = "${var.subnet_id}"
}

build {
  sources = ["source.amazon-ebs.autogenerated_1"]

  provisioner "shell" {
    script = "script.sh"
  }

}
