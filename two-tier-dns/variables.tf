# Terraform - variables.tf

variable "project_name" {
	description = "project name"
}

variable "domain" {
   description = "your domain"
}

#variable "sub_domain" {
#   description = "my_sub_domain"
#}

variable "record" {
   description = "server name for your app"
}

variable "account_file_path" {
	description = "json file for auth"
	default = "~/.gcloud/gcloud.json"
}

variable "ssh_user" {
	description = "ssh user"
	default = "sysadm"
}

variable "public_key_path" {
	description = "public key path"
	default = "~/.ssh/id_rsa_gcloud.pub"
}

variable "private_key_path" {
	description = "private key path"
	default = "~/.ssh/id_rsa_gcloud"
}

variable "install_path" {
	description = "install path"
	default = "setup.d"
}

variable "region" {
	default = "europe-west1"
}

variable "region_zone" {
	default = "europe-west1-b"
}

# EOF
