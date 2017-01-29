function Get-WLUser {
    [CmdletBinding()]
    Param (
        [Parameter()][string]$Id
    )
    Invoke-RestMethod -Uri 'a.wunderlist.com/api/v1/user' -Headers $Script:headers -Method Get
}