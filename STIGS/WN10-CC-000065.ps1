<#
.SYNOPSIS
This security control ensures that local drives on a client computer are not accessible during Remote Desktop sessions

.NOTES
    Author          : Steven Arterbery
    LinkedIn        : linkedin.com/in/steven-arterbery/
    GitHub          : github.com/StevenArter
    Date Created    : 2025-04-07
    Last Modified   : 2025-04-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000065

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000065 ).ps1 
#>

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config\AutoConnectAllowedOEM"

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the DWORD value (assumes you want to name it something appropriate instead of "New Value #1")
Set-ItemProperty -Path $registryPath -Name "New Value #1" -Value 0 -Type DWord

Write-Host "Registry value 'New Value #1' set to 0 at $registryPath"
