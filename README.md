# terraform_gcloud

Premiers pas avec Terraform et Google Cloud Platform.

On cherche à déployer une application (https://github.com/dmuth/guestbook) sur Google Cloud Platform à l'aide de Terraform. Dans un premier temps on va déployer une instance GCE qui hébergera l'ensemble de l'application (serveur web, base de données et code) puis on évoluera vers une infrastructure deux tiers.

## Simple

### Objectif

Mise en place d'une instance GCE avec :
* nginx
* php-fpm
* mysql

Fournir en sortie l'adresse IP permettant d'accéder à l'application. 

### Déploiement

Après voir cloné ce repository il faudra :

```
# Génération d'une paire de clé sans passphrase
ssh-keygen -f ~/.ssh/id_rsa_gcloud
```

``` 
mkdir -p ~/.gcloud/
# Télécharger votre fichier d'authentification json ici (~/.gcloud/gcloud.json)
```

```
cd simple
terraform apply -var="project_name=myproject" 
```

### Suppression

```
terraform destroy -var="project_name=myproject" 
```

## Ressources

* https://github.com/hashicorp/terraform/
*  https://www.terraform.io/
