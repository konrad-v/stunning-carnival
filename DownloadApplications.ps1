$ProgressPreference = 'SilentlyContinue'

$Sources = Get-Content ".\application.source.json" | Out-String | ConvertFrom-Json

New-Item ".\Applications" -ItemType Directory -Force | Out-Null

foreach ($Application in $Sources.Applications) {
    Write-Host "Downloading $($Application.Title)"
    if ($Application.Source -eq "web") {
        New-Item (Split-Path $Application.Destination -Parent) -ItemType Directory -Force | Out-Null
        Invoke-WebRequest $Application.Uri -OutFile $Application.Destination
    }
    else {
        New-Item $Application.Destination-ItemType Directory -Force | Out-Null
        foreach ($File in $Application.Files) {
            Copy-Item -Path "filesystem::$File" -Destination "$($Application.Destination)\"
        }
    }
}