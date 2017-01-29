function Get-WLAvatar {
    [CmdletBinding()]
    Param (
        [Parameter()][string]$UserID
    )

    Invoke-RestMethod -Uri ('a.wunderlist.com/api/v1/avatar?user_id={0}' -f $Id) -Headers $Script:headers -Method Get
}