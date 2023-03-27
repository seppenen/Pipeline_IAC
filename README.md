
# Pipeline_IAC

This project is based on Terraform. These scripts create a pipeline in the DevOps portal and cloud environment during the pipeline runtime, and deploy application containers.

## The following definitions will be created:

Azure DevOps environment:

- Repos and policies
- Pipelines including policies, JUnit, Lint, and SonarQube tests
- Environments in Azure portal (Kubernetes, pSql, ACR, analytics, SonarQube server, and configuration)

 Pipeline stages: 
- Cloud provision
- Validation
- Deployment
- Destroy

## Pipeline functionality:

### Feature branch:

- Lint
- Build
- Unit
- Story acceptance (Gherkin / Cucumber)
- Save the HTML reports produced by the tests to the CI tool
- Prevent the branch from being merged into the master if even one test fails

### Master branch:
- Validation / all above
- Cloud provision
- SQL server provision and configuration
- SonarQube analysis
- Retrieve information from that analysis and reports
- Stop if the test fails
- Build container
- Take it to Artifactory / repository
- Push to ACR
- Deploy container to Kubernetes cluster

#### Workflow process:
![img_1.png](img_1.png)
![img.png](img.png)



#### Schema
![img_2.png](img_2.png)
## Environment installation



### Requirements:

- DevOps PAT
- Service principal with Owner role in subscription scope
- DevOps organization admin or permissions to install extensions
- Java Maven application

### Maven dependencies: 
- cucumber-java
- sonar-maven-plugin
- junit-jupiter-api


### Sonarqube requirements:

Configure property sonar.projectKey to pom.xml.
The value "new_project" is hardcoded value to Terraform scipts. Do not change this value.
```bash 
<sonar.version>3.7.0.1746</sonar.version>
<sonar.projectKey>new_project</sonar.projectKey>
``` 
#Installation

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

## Quick installation

```bash 
./scripts/init.ps1
``` 

The created repo URL will be printed out to the console

## Manual installation

Initialize local state using the following commandsЮ

```bash 
terraform init
``` 
Install the remote backend:
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
terraform apply -destroy -auto-approve -target="module.<moduleName>"   
```

Sync with created repo

```bash 
git init
git remote add origin <url>
git fetch --all
```
Restart your IDE. Do not commit files to the main branch as it is locked and prevented from merge. Only pull requests are possible. Checkout the "feature" branch first and commit and push all files to it.

