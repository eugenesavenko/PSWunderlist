function Get-WLList {
    [OutputType('Wunderlist.List')]
    [CmdletBinding()]
    Param (
        [Parameter()][Int]$ListID
    )
    begin {
        if ($PSBoundParameters.ContainsKey('ListID')) {
            $Query = ('{0}/lists/{1}' -f $Script:BaseUri, $PSBoundParameters['ListID'])
        } else {
            $Query = ('{0}/lists' -f $Script:BaseUri)
        }
        $Lists = Invoke-RestMethod -Uri $Query -Headers $Script:headers -Method Get -ContentType 'application/json'
    }
    process {
        foreach ($List in $Lists) {
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
    }
}