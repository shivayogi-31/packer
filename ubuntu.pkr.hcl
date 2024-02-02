source "amazon-ebs" "ubuntu" {
  ami_name      = "ubuntu-image"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  source_ami    = "ami-03f4878755434977f"
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }
}
