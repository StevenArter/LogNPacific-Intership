<#
.SYNOPSIS
This PowerShell script sets a Windows boot policy that controls which drivers are allowed to load during startup. I used value 8 which means only good drivers are allowed to load during early boot.

.NOTES
    Author          : Steven Arterbery
    LinkedIn        : linkedin.com/in/steven-arterbery/
    GitHub          : github.com/StevenArter
    Date Created    : 2025-04-05
    Last Modified   : 2025-04-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000085

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000085 ).ps1 
#>

# Set 'DriverLoadPolicy' under the EarlyLaunch policy key
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Policies\EarlyLaunch" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Policies\EarlyLaunch" -Name "DriverLoadPolicy" -Value 0x8 -Type DWord
