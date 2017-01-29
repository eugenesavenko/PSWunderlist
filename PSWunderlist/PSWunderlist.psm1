#TODO 'Generate help with platyPS'
$Script:BaseUri = 'https://a.wunderlist.com/api/v1'
$Script:ClientID = $null
$Script:AccessToken = $null

$ProgressPreference = 'SilentlyContinue'

$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

Foreach($import in @($Public + $Private)) {
    Try {
        . $import.fullname
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Update-FormatData -AppendPath (Join-Path $PSScriptRoot '*.format.ps1xml') -ErrorAction SilentlyContinue
#Update-TypeData -AppendPath (Join-Path $PSScriptRoot '*.types.ps1xml') -ErrorAction SilentlyContinue