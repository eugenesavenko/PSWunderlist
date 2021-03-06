# Deploy to Powershell Gallery only where there is a tag which will have the version number
$deploy = ($env:APPVEYOR_REPO_TAG -eq $true)
if ($deploy)
{
    $gitOut = git checkout master 2>&1
    Write-Host "Starting Deployment tag $env:APPVEYOR_REPO_TAG_NAME"      
    $moduleName = "PSWunderlist"
    $currentVersion = (Import-PowerShellDataFile .\PSWunderlist\$moduleName.psd1).ModuleVersion
    ((Get-Content .\PSWunderlist\PSWunderlist.psd1).replace("ModuleVersion = '$($currentVersion)'", "ModuleVersion = '$($env:APPVEYOR_REPO_TAG_NAME)'")) | Set-Content .\PSWunderlist\$moduleName.psd1
    Publish-Module -Path .\PSWunderlist -NuGetApiKey $env:nugetKey

    git config --global core.safecrlf false
    git config --global credential.helper store
    Add-Content "$env:USERPROFILE\.git-credentials" "https://$($env:github_access_token):x-oauth-basic@github.com`n"
    git config --global user.email "ionut@ionutmaxim.ro"
    git config --global user.name "Ionut Maxim"
    git add PSWunderlist\PSWunderlist.psd1  
    git commit -m "Automatic Version Update from CI"
    $gitOut = git push 2>&1
    if ($?) {$out} else {$out.Exception}
}