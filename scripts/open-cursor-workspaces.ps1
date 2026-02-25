# Open one Cursor window per country (Mother's Day sites).
# Run from repo root or any folder. Requires "cursor" in PATH.
# Usage: .\scripts\open-cursor-workspaces.ps1
#        .\scripts\open-cursor-workspaces.ps1 -Base "C:\Users\FEVER\Documents\MOTHERS DAY"

param(
    [string]$Base = "C:\Users\FEVER\Documents\MOTHERS DAY"
)

$countries = @("ES", "FR", "DE", "IT", "MX", "BR", "CA", "AU")
foreach ($c in $countries) {
    $path = Join-Path $Base $c
    if (Test-Path $path) {
        Write-Host "Opening Cursor: $path"
        & cursor $path
    } else {
        Write-Warning "Folder not found: $path"
    }
}
