[CmdletBinding()]
param (
    [Parameter(Mandatory=$True)]
    [string]
    $Title,
    # Parameter help description
    [Parameter(Mandatory=$True)]
    [string[]]
    $Files,
    # Parameter help description
    [Parameter(Mandatory=$True)]
    [string]
    $Destination,
    # Parameter help description
    [Parameter(Mandatory=$True)]
    [string]
    $Arguments
)

$ApplicationSourceJSON = ".\application.source.json"
if (Test-Path $ApplicationSourceJSON) {
    $Sources = Get-Content ".\application.source.json" | Out-String | ConvertFrom-Json
}
else {
    $Sources = @{ Applications = @()}
}

$Source = @{
    Title = $Title
    Source = "share"
    Files = $Files
    Destination = $Destination
    Arguments = $Arguments
}

$Sources.Applications += $Source
$Sources | ConvertTo-Json -Depth 10 | Set-Content ".\application.source.json"
