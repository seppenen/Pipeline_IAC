Write-Host "`n[INIT INFO] Destroying...`n" -ForegroundColor Green

$ErrorActionPreference = "SilentlyContinue"
terraform apply -destroy -auto-approve  -target="module.sq_config" -target="module.sonarqube" -target="module.app" -target="module.shared" -target="module.ado" -target="module.backend"   | Write-Output
