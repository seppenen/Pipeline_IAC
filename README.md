
This scripts creates azure cloud environment and deploy application container to kubernetes.

##Following definitions will be created:

Azure Devops environment

Repos and policy 

Pipelines including policy, junit, lint, sonarqube tests

Environment in Azure portal (kubernetes, pSql, ACR, analytics)

Pipeline stages: Cloud provision, Validation, Deployment, Destroy.


## Environment installation

Provide the personal access token (PAT) for the Azure DevOps organization, service principal and client secret. You can create a PAT token by following the instructions [here](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=preview-page).



Configure following env variables:
```bash 
# PowerShell
> $env:ARM_CLIENT_ID = "00000000-0000-0000-0000-000000000000"
> $env:ARM_CLIENT_SECRET = "12345678-0000-0000-0000-000000000000"
> $env:ARM_TENANT_ID = "10000000-0000-0000-0000-000000000000"
> $env:ARM_SUBSCRIPTION_ID = "20000000-0000-0000-0000-000000000000"
> $env:AZDO_PERSONAL_ACCESS_TOKEN  = "000000000000000000000000"
> $env:AZDO_ORG_NAME="DevOpsOrgName"

``` 

##Quick installation

```bash 
./scripts/init.ps1
``` 

Find on output repo URL.

##Manual installation

Initialize local state using the following commands:
```bash 
terraform init
``` 
Install remote backend:
```bash 
terraform apply -auto-approve -target="module.backend"
```
Migrate state
```bash 
terraform init -migrate-state 
```


## Usage

Setup ADO resources using the following commands:
```bash 
terraform apply -auto-approve -target="module.ado"   
```
Clean up:
```bash
terraform apply -destroy -auto-approve -target="module.ado"   
```

Sync with created repo

```bash 
git init
git remote add origin <url>
git fetch --all
```
Restart IDE.

Do not commit files to main branch as it is locked and prevented from merge, only pull request is possible. Checkout firstly "feature" branch and commit and push all files.

