## Init script for the sequence of commands to set terraform and create ADO environment
## Before running this script you need to export necessary environment variables
## Command from terraform root directory: .\scripts\init.ps1

Write-Host "`n[INIT INFO] Setting Terraform and Creating ADO Environment...`n" -ForegroundColor Green

# Remove backend.tf, if exists
if (Test-Path -path "backend.tf") {
    Write-Host "Removing backend.tf"
    Remove-Item "backend.tf"
}

# Initilize terraform locally
terraform init | Write-Output

# Check for errors
if ($LASTEXITCODE -ne 0) {
    Write-Error "Terraform init failed. Check the error!"
    exit 1
}

# Creating remote backend using backend module
Write-Host "`n[INIT INFO] Creating remote backend..."-ForegroundColor Green
terraform apply -auto-approve -target="module.backend"  | Write-Output

# Check for errors
if ($LASTEXITCODE -ne 0) {
    Write-Error "Creating backend failed. Check the error!"
    exit 1
}

# Migrating state
Write-Host "`n[INIT INFO] Migrating state..." -ForegroundColor Green
terraform init -migrate-state -force-copy  | Write-Output

# Check for errors
if ($LASTEXITCODE -ne 0) {
    Write-Error "Migrating backend failed. Check the error!"
    exit 1
}

# Apply ADO module to create ADO environment
Write-Host "`n[INIT INFO] Creating ADO environment..." -ForegroundColor Green
terraform apply -auto-approve  -target="module.ado"  | Write-Output

# Check for errors
if ($LASTEXITCODE -ne 0) {
    Write-Error "Creating ADO failed. Check the error!"
    exit 1
}

# Clearing state files
$files = "terraform.tfstate","terraform.tfstate.backup"
foreach ($file in $files)
{
    if (Test-Path -path $file) {
        Write-Host "`n[INIT INFO] Removing local state $file"
        Remove-Item $file
    }
}

Write-Host "`n[INIT INFO] Setup completed successfully" -ForegroundColor Green
Write-Warning "[INIT INFO] Remember to NEVER commit backend.tf into version control"