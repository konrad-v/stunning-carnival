[CmdletBinding()]
param (
    [Parameter(Mandatory=$True)]
    [string]
    $Title,
    # Parameter help description
    [Parameter(Mandatory=$True)]
    [string]
    $Uri,
    # Parameter help description
    [Parameter(Mandatory=$True)]
    [string]
    $Destination,
    # Parameter help description
    [Parameter(Mandatory=$True)]
    [string]
    $Arguments
)

$Sources= Get-Content ".\application.source.json" | Out-String | ConvertFrom-Json

$Source = @{
    Title = $Title
    Source = "web"
    Uri = $Uri
    Destination = $Destination
    Arguments = $Arguments
}

$Sources.Applications += $Source
$Sources | ConvertTo-Json -Depth 10 | Set-Content ".\application.source.json"
