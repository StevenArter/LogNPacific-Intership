<#
.SYNOPSIS
Administrator account status" policy be set to "Disabled" to prevent the default Administrator account from being used for unauthorized access
.NOTES
    Author          : Steven Arterbery
    LinkedIn        : linkedin.com/in/steven-arterbery/
    GitHub          : github.com/StevenArter
    Date Created    : 2025-04-07
    Last Modified   : 2025-04-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000170

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000170 ).ps1 
#>

# Define the registry path and key-value
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\MSAOptional"
$keyName = "New Value #1"
$keyValue = 1

# Check if the registry path exists, create if it doesn't
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $keyName -Value $keyValue

Write-Host "Registry value has been set."
