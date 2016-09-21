# terraform_gcloud

Premiers pas avec Terraform et Google Cloud Platform.

## Prérequis

* Installer Terraform (https://www.terraform.io/downloads.html)
* Créer un nouveau projet Google Cloud Platform
* Récupérer le fichier d'authentification au format json (IAM & Administration -> Comptes de service -> Compute Engine default service account -> Créer une clé)

## Utilisation

```
ssh-keygen -f ~/.ssh/id_rsa_gcloud 	# sans passphrase
mkdir -p ~/.gcloud/					# y déposer le fichier gcloud.json
...
terraform plan -var="project_name=myproject"
terraform apply -var="project_name=myproject"
terraform destroy -var="project_name=myproject"
```

## Ressources

* https://github.com/hashicorp/terraform/
*  https://www.terraform.io/
