# Terraform - network.tf

# Network
resource "google_compute_network" "network1" {
    name            = "network1"
}

resource "google_compute_subnetwork" "subnetwork1" {
    name            = "guestbook"
    ip_cidr_range   = "10.10.10.0/24"
    network         = "${google_compute_network.network1.self_link}"
    region          = "${var.region}"
}

# Firewall rules
resource "google_compute_firewall" "db-firewall" {
    name            = "db-firewall"
    network         = "${google_compute_network.network1.name}"

    allow {
        protocol    = "tcp"
        ports       = ["3306"]
    }

    source_ranges	= ["${google_compute_subnetwork.subnetwork1.ip_cidr_range}"]
	target_tags		= ["db"]
}

resource "google_compute_firewall" "web-firewall" {
    name            = "web-firewall"
    network         = "${google_compute_network.network1.name}"

    allow {
        protocol    = "tcp"
        ports       = ["80", "22"]
    }

    target_tags     = ["web"]
}

resource "google_compute_firewall" "generic-firewall" {
    name            = "generic-firewall"
    network         = "${google_compute_network.network1.name}"

    allow {
        protocol    = "tcp"
        ports       = ["22"]
    }

	allow {
		protocol	= "icmp"
	}	
}

# EOF
