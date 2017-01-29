function Set-WLTask {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [PSTypeName('Wunderlist.Task')]
        [System.Object[]]
        $InputObject,
        [Parameter()][long]$TaskID,
        [Parameter()][string]$Title,
        [Parameter()][bool]$Completed
    )
    begin {

    }
    
    process {
        $Data = [Ordered]@{
            'revision' = $InputObject.Revision
        }
        switch ($PSBoundParameters.Keys) {
            'Title' { $Data.title = $PSBoundParameters.Values[$_] } 
            'Completed' { $Data.completed = $true } 
        }
        $Query = ('{0}/tasks/{1}' -f $Script:BaseUri, $InputObject.TaskID)
        $Data = ConvertTo-Json -InputObject $Data
        #$Data
        Write-Host $PSBoundParameters.Values['completed']
        Invoke-RestMethod -Uri $Query -Headers $Script:headers -Method Patch -ContentType 'application/json' -Body $Data
    }
}
