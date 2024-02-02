packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0, < 2.0.0"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-image"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  source_ami    = "ami-03f4878755434977f"
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  builders = [
    {
      type          = "amazon-ebs"
      region        = "ap-south-1"
      instance_type = "t2.micro"
      ssh_username  = "ubuntu"
      ami_name      = "ubuntu-image-{{timestamp}}"
    }
  ]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }
}
