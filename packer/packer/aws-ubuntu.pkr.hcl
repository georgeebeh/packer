packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.2.0"
    }
  }
}

source "amazon-ebs" "aws_ubuntu" {
  ami_name      = "my_aws_ubuntu{{timestamp}}"
  instance_type = "t2.micro"
  region        = "eu-west-2"
  source_ami    = "ami-0505148b3591e4c07"
  ssh_username  = "ubuntu"
}

build {
  name    = "aws_ubuntu"
  sources = ["source.amazon-ebs.aws_ubuntu"]

  provisioner "shell" {
    script = "packer/install.sh"

  /*provisioner "ansible" {
      command = "ansible-playbook"
      playbook_file = "pre_build_controller.yml"
      user = "ubuntu"
      inventory_file_template = "controller ansible_host={{ .Host }} ansible_user={{ .User }} ansible_port={{ .Port }}\n"
      extra_arguments = local.extra_args

    } */ 
  }
}
