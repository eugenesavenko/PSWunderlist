function New-WLList {
    [CmdletBinding()]
    Param (
        [Parameter()][string]$Title
    )

    $Parameters = @{
        title = $Title
    } | ConvertTo-Json

    $List = Invoke-RestMethod -Uri ('{0}/lists' -f $Script:BaseUri) -Headers $Script:headers -Method Post -Body $Parameters -ContentType 'application/json'
    $Object = New-Object -TypeName PSCustomObject -Property @{
            ListID = [Int]$List.id
            Title = $List.title
            OwnerType = $List.owner_type
            OwnerID = [Int]$List.owner_id
            ListType = $List.list_type
            Public = $List.public
            Revision = [int]$List.revision
            CreatedAt = [datetime]::Parse($List.created_at)
            CreatedByRequestID = $List.created_by_request_id
            Type = $List.type
        }
        $Object.pstypenames.insert(0,'Wunderlist.List')
        Write-Output -InputObject $Object

}