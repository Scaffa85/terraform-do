resource "digitalocean_droplet" "www-1" {
  count              = 0
  image              = "ubuntu-14-04-x64"
  name               = "www-1"
  region             = "lon1"
  size               = "512mb"
  private_networking = true

  ssh_keys = [
    "${var.ssh_fingerprint}",
  ]

  connection {
    user        = "root"
    type        = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",

      # install nginx
      "sudo apt-get update",

      "sudo apt-get -y install nginx",
    ]
  }
}
