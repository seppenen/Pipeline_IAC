
# Overview

The purpose of this Terraform application is to automate the process of creating infrastructure in Azure portal and environment in Azure DevOps portal. This includes setting up repositories, policies, and pipelines with multiple stages, including cloud provision, validate, deploy, and destroy. The pipeline has the ability to provision necessary infrastructure during runtime in Azure portal, such as a Kubernetes cluster, Postgres database, analytics, container registry, and other necessary resources. Additionally, the pipeline can run tests such as jUnit, Lint, Sonarqube analysis and Cucumber/Gherkin to ensure that the application is functioning correctly. Please note that this Terraform application is only compatible with Java Maven applications, and requires the installation of certain Maven dependencies, including cucumber-java, sonar-maven-plugin, and junit-jupiter-api.

# Prerequisites
Before using this application, you must have the following prerequisites set up:

- An Azure DevOps account with appropriate permissions to create repositories, policies, install extensions and pipelines.
- An Azure subscription with appropriate permissions to create resources in the Azure portal.
- A service principal with the Owner role assigned at the subscription scope.
- Azure DevOps personal access token with appropriate permissions.
- Terraform installed on your machine.
- Required maven dependencies: cucumber-java, sonar-maven-plugin, junit-jupiter-api
- The pom.xml file must exist and have the sonar.projectKey value set to "new_project".


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
- SQ server provision and configuration
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


### Maven dependencies: 
- cucumber-java
- sonar-maven-plugin
- junit-jupiter-api

The Sonar project name, "new_project," is a hardcoded value that enables automatic registration of the project in the SQ server via the Terraform sq_config module. It is important not to change this value.

#### Example
```bash 
<sonar.version>3.7.0.1746</sonar.version>
<sonar.projectKey>new_project</sonar.projectKey>
``` 
# Installation

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

The URL for the newly created repository will be displayed on the console.

## Manual installation

Initialize local state using the following commands

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

Destruction:
```bash
terraform apply -destroy -auto-approve -target="module.<moduleName>"   
```

Sync with created repo

```bash 
git init
git remote add origin <url>
git fetch --all
```
Note: Remember to commit and push all files to the "feature" branch, as the main branch is locked and prevented from merge. Only pull requests are possible.

