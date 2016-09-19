# Terraform - main.tf

provider "google" {
	region = "${var.region}"
	project = "${var.project_name}"
	credentials = "${file("${var.account_file_path}")}"
}

resource "google_compute_instance" "guestbook" {
	name         = "guestbook"
	machine_type = "g1-small"
	zone         = "${var.region_zone}"
	
	disk {
		image = "debian-8-jessie-v20160803"
	}
	
	network_interface {
		network = "default"
		access_config { }
	}

	metadata {
		ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
	}
	
	connection {
		user = "${var.ssh_user}" 
		type = "ssh"
		key_file = "${file("${var.private_key_path}")}"		
	}
	
	provisioner "file" {
		source = "${var.install_path}"
		destination = "/tmp"
	}
	
	provisioner "remote-exec" {
		inline = [
			"sudo /bin/bash /tmp/${var.install_path}/install.sh",
			"sudo rm -fr /tmp/${var.install_path}"
		]
	}
}

resource "google_compute_firewall" "firewall" {
	name = "firewall"
	network = "default"

	allow {
		protocol = "tcp"
		ports = ["80"]
	}
}

# EOF
