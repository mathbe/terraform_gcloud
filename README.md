# terraform_gcloud

Premiers pas avec Terraform et Google Cloud Platform.

## Prérequis

* Installer Terraform (https://www.terraform.io/downloads.html)
* Créer un nouveau projet Google Cloud Platform
* Récupérer le fichier d'authentification au format json (IAM & Administration -> Comptes de service -> Compute Engine default service account -> Créer une clé)

## Utilisation

```bash
ssh-keygen -f ~/.ssh/id_rsa_gcloud 	# sans passphrase
mkdir -p ~/.gcloud/					# y déposer le fichier gcloud.json
...
terraform plan -var="project_name=myproject"
terraform apply -var="project_name=myproject"
terraform destroy -var="project_name=myproject"
```

Pour la version avec enregistrement DNS, si on souhaite que notre application soit joignable via app.subdomain.mydomain.com on utilisera la commande terraform suivante:  

```bash
terraform apply -var="project_name=myproject" -var="subdomain.domain.com." -var="record=app"

```
L'output Terraform indiquera les NS à configurer dans la zone supérieure, mydomain.com dans notre exemple.

## Ressources

* https://github.com/hashicorp/terraform/
*  https://www.terraform.io/
