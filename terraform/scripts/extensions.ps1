param(
    [Parameter(Mandatory=$true)]
    [String]$pat,
    
    [Parameter(Mandatory=$true)]
    [String]$orgName
    )

$orgUrl = "https://extmgmt.dev.azure.com/$orgName"
$queryString = "api-version=7.1-preview"

class Extension {
    [string] $extensionId
    [string] $publisherId
    [string] $version
}

$extensionSet = @(
[Extension]@{
    extensionId='sonarqube';
    publisherId="SonarSource";
    version="5.10.0"
}
[Extension]@{
    extensionId='azure-pipelines-cucumber';
    publisherId="MaciejMaciejewski";
    version="1.0.8"
}
[Extension]@{
    extensionId='sonar-buildbreaker';
    publisherId="SimondeLang";
    version="8.1.2"
}
[Extension]@{
    extensionId='custom-terraform-tasks';
    publisherId="ms-devlabs";
    version="0.1.19"
}
[Extension]@{
    extensionId='terraform-outputs';
    publisherId="raul-arrieta";
    version="0.0.43"
}
[Extension]@{
    extensionId='RunPipelines';
    publisherId="CSE-DevOps";
    version="2.4.2"
}
)

# Create header using PAT
$token = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($pat)"))
$header = @{authorization = "Basic $token"}

foreach ($extensionMember in $extensionSet){
    try {
        $installedExtensionsUrl= "$orgUrl/_apis/extensionmanagement/installedextensions"+'?'+$queryString
        
        #Fetch installed extensions:
        $extensions = Invoke-RestMethod -Uri $installedExtensionsUrl -Method Get -ContentType "application/json" -Headers $header
        
        #Find out if current extension is already installed:
        $result = $extensions.value.Where({$_.extensionId -eq $extensionMember.extensionId});
        
        if ($result.Count -eq 0){
            # Install extension:
            $installExtensionUrl = "$orgUrl/_apis/extensionmanagement/installedextensionsbyname/"+$extensionMember.publisherId+"/" + $extensionMember.extensionId + "/" + $extensionMember.version +'?'+$queryString
            $extension = Invoke-RestMethod -Uri $installExtensionUrl -Method Post -Headers $header -ContentType "application/json"
            $extension
            Write-Host "INFO: Extension " $extensionMember.extensionId " installed."
        }else{
            Write-Host "INFO: Extension " $extensionMember.extensionId " was found to be already installed."
        }
        
      }catch{
        Write-Host "ERROR: Azure DevOps Extensions error during installation of " + $extensionMember.extensionId
        Write-Host $_
      }
}