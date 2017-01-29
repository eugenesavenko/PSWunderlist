function Set-WLAuthentication {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)][string]$Client,
        [Parameter(Mandatory=$true)][string]$Token
    )
    $Script:ClientID = $Client
    $Script:AccessToken = $Token

    $Script:headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $Script:headers.Add("X-Client-ID", $Script:ClientID)
    $Script:headers.Add("X-Access-Token", $Script:AccessToken)
}