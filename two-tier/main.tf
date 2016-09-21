# Terraform - main.tf

provider "google" {
	region		= "${var.region}"
	project 	= "${var.project_name}"
	credentials = "${file("${var.account_file_path}")}"
}

# Frontend web 
resource "google_compute_instance" "web" {
	count			= 2
	name			= "web-${count.index}"
	machine_type	= "g1-small"
	zone			= "${var.region_zone}"
	tags			= ["web"]
	
	disk {
		image = "debian-8-jessie-v20160803"
	}
	
	network_interface {
		subnetwork  = "${google_compute_subnetwork.subnetwork1.name}"
		access_config { }
	}

	metadata {
		ssh-keys 	= "${var.ssh_user}:${file("${var.public_key_path}")}"
	}
	
	connection {
		user		= "${var.ssh_user}" 
		type 		= "ssh"
		key_file 	= "${file("${var.private_key_path}")}"		
	}
	
	provisioner "file" {
		source 		= "${var.install_path}"
		destination = "/tmp"
	}
	
	provisioner "remote-exec" {
		inline = [
			"sudo /bin/bash /tmp/${var.install_path}/install-web.sh",
			"sudo rm -fr /tmp/${var.install_path}"
		]
	}
}

# Database
resource "google_compute_instance" "db" {
    name            = "db"
    machine_type    = "g1-small"
    zone            = "${var.region_zone}"
    tags            = ["db"]

    disk {
        image = "debian-8-jessie-v20160803"
    }

    network_interface {
        subnetwork  = "${google_compute_subnetwork.subnetwork1.name}"
		address     = "10.10.10.10"
        access_config { }
    }

    metadata {
        ssh-keys    = "${var.ssh_user}:${file("${var.public_key_path}")}"
    }

    connection {
        user        = "${var.ssh_user}"
        type        = "ssh"
        key_file    = "${file("${var.private_key_path}")}"
    }

    provisioner "file" {
        source      = "${var.install_path}"
        destination = "/tmp"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo /bin/bash /tmp/${var.install_path}/install-db.sh",
            "sudo rm -fr /tmp/${var.install_path}"
        ]
    }
}

# EOF
