<#
.SYNOPSIS
The minimum password age must be configured to at least 1 day.

.NOTES
    Author          : Steven Arterbery
    LinkedIn        : linkedin.com/in/steven-arterbery/
    GitHub          : github.com/StevenArter
    Date Created    : 2025-04-07
    Last Modified   : 2025-04-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000030 ).ps1 
#>

# Get current minimum password age
$minPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MinPasswordAge.Days

# If the current setting is less than 1 day, update it
if ($minPasswordAge -lt 1) {
    # Set MinimumPasswordAge to 1 day
    net accounts /minpwage:1
    Write-Output "Minimum password age was less than 1 day. It has been set to 1 day."
} else {
    Write-Output "Minimum password age is already set to $minPasswordAge day(s). No changes made."
}
