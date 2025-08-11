# my-palworld

Build a dedicated server on Google Cloud using Terraform.

## How to set up

### Create Google Cloud Project

- Create Google Cloud Project
  - https://console.cloud.google.com/projectcreate
- Enable google APIs
  ```
  gcloud services enable compute.googleapis.com
  gcloud services enable secretmanager.googleapis.com
  gcloud services enable run.googleapis.com
  ```

### Set envs

Create a file named terraform.tfvars and set environments

```sh
touch ./infra/terraform/env/prod/service/palworld-server/terraform.tfvars
```

```tfvars terraform.tfvars
project_id = "your_project_id"
server_password = "pass"
admin_password  = "admin_pass"
palworld_server_name = "Aincrad"
palworld_server_description = "This is a game. But is not a playing."
palworld_server_tz = "UTC"
```

Ref:
https://github.com/thijsvanloef/palworld-server-docker

### Terraform apply

```sh
# Set account and project
gcloud config set account <your email>
gcloud config set project <your google cloud project id>
gcloud auth application-default login

# Make bucket to manage terraform state
gsutil mb gs://my-palworld-tfstate

# terraform
cd ./infra/terraform/env/prod/service/palworld-server
terraform init
terraform plan -var-file terraform.tfvars
terraform apply -var-file terraform.tfvars
```

### Access to server

1. Access the created Google Cloud GCE and check the 'External IP'.

- https://console.cloud.google.com/compute/instances
- e.g. 34.123.123.123

2. Launch Palworld and join from the dedicated server.

- Check the box for password input, enter '<address confirmed in step 1>:8211', and connect.
- e.g.「34.123.123.123:8211」
