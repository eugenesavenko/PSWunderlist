function Get-WLTask {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [PSTypeName('Wunderlist.List')]
        [System.Object[]]
        $InputObject,
        [Parameter()][long]$ListID,
        [Parameter()][switch]$Completed,
        [Parameter()][int]$TaskID
    )
    DynamicParam {
        $Lists = Get-WLList
        New-DynamicParam -Name List -ValidateSet @($Lists.Title)
    }
    begin {
        if ($PSBoundParameters.ContainsKey('Completed')) {
            $Query = ('{0}/tasks?completed=true;' -f $Script:BaseUri)
        } else {
            $Query = ('{0}/tasks?' -f $Script:BaseUri)
        }
    }
    
    process {
        $Query += ('list_id={0}' -f $InputObject.ListID)
        $Tasks = Invoke-RestMethod -Uri $Query -Headers $Script:headers -Method Get -ContentType 'application/json'
        foreach ($Task in $Tasks) {
            $Object = New-Object -TypeName PSCustomObject -Property @{
                TaskID = [long]$Task.id
                Title = $Task.title
                CreatedByID = $Task.created_by_id
                CreatedByRequestID = $Task.created_by_request_id
                RecurrenceType = $Task.recurrence_type
                RecurenceCount = [int]$Task.recurrence_count
                DueDate = $Task.due_date
                Completed = $Task.completed
                Starred = $Task.starred
                ListID = $Task.list_id
                Revision = [int]$Task.revision
                CreatedAt = [datetime]::Parse($Task.created_at)
                Type = $Task.type
            }
            $Object.pstypenames.insert(0,'Wunderlist.Task')
            Write-Output -InputObject $Object
        }
    }
}