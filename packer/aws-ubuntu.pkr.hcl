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

 tags = {
    Name = "aws_ubuntu"
  }

}

build {
  name    = "aws_ubuntu"
  sources = ["source.amazon-ebs.aws_ubuntu"]

  provisioner "shell" {
  inline = [
    "sudo apt-get update",
    "sudo apt-get install -y software-properties-common",
    "sudo apt-add-repository --yes --update ppa:ansible/ansible",
    "sudo apt-get install -y ansible",
    "ansible-galaxy install m18unet.terraform"
  ]
}


  provisioner "file" {
    source      = "./playbook.yml"
    destination = "/tmp/playbook.yml"
  }

  provisioner "shell" {
  inline = [
    "echo 'Running Ansible playbook'",
    "ansible-playbook /tmp/playbook.yml"
  ]

 }
   
}

