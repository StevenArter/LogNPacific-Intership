<#
.SYNOPSIS
This script configures the Windows 10 system Password Policy to make passwords a minimum of 14 characters

.NOTES
    Author          : Steven Arterbery
    LinkedIn        : linkedin.com/in/steven-arterbery/
    GitHub          : github.com/StevenArter
    Date Created    : 2025-04-07
    Last Modified   : 2025-04-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000035 ).ps1 
#>

# Set minimum password length to 14 characters
$infPath = "$env:TEMP\secpol.inf"
$logPath = "$env:TEMP\secpol.log"

# Export current security settings
secedit /export /cfg $infPath

# Replace or insert the MinimumPasswordLength setting
$content = Get-Content $infPath
if ($content -match "^MinimumPasswordLength") {
    $content = $content -replace "^MinimumPasswordLength\s*=\s*\d+", "MinimumPasswordLength = 14"
} else {
    $index = $content.IndexOf("[System Access]") + 1
    while ($index -lt $content.Count -and $content[$index] -notmatch "^\[.*\]") {
        $index++
    }
    $content = $content[0..($index-1)] + "MinimumPasswordLength = 14" + $content[$index..($content.Count - 1)]
}

# Save the modified security template
Set-Content -Path $infPath -Value $content

# Apply the modified settings
secedit /configure /db secedit.sdb /cfg $infPath /log $logPath /quiet

Write-Host "Minimum password length has been set to 14 characters."
