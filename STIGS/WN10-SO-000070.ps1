<#
.SYNOPSIS
This script configures the Windows 10 system policy  by setting ConsentPromptBehaviorAdmin to 5, which enforces user consent for elevation with credentials on the secure desktop

.NOTES
    Author          : Steven Arterbery
    LinkedIn        : linkedin.com/in/steven-arterbery/
    GitHub          : github.com/StevenArter
    Date Created    : 2025-04-06
    Last Modified   : 2025-04-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000070

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000070 ).ps1 
#>

# Base System policy path
$basePath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Create the base key if it doesn't exist
if (-not (Test-Path $basePath)) {
    New-Item -Path $basePath -Force | Out-Null
}

# Set DWORD registry values
$registryValues = @{
    "ConsentPromptBehaviorAdmin"     = 0x5
    "ConsentPromptBehaviorUser"      = 0x3
    "DSCAutomationHostEnabled"       = 0x2
    "EnableCursorSuppression"        = 0x1
    "EnableFullTrustStartupTasks"    = 0x2
    "EnableInstallerDetection"       = 0x1
    "EnableLUA"                      = 0x1
    "EnableSecureUIAPaths"           = 0x1
    "EnableUIADesktopToggle"         = 0x0
    "EnableUwpStartupTasks"          = 0x2
    "EnableVirtualization"           = 0x1
    "PromptOnSecureDesktop"          = 0x1
    "SupportFullTrustStartupTasks"   = 0x1
    "SupportUwpStartupTasks"         = 0x1
    "ValidateAdminCodeSignatures"    = 0x0
    "dontdisplaylastusername"        = 0x0
    "scforceoption"                  = 0x0
    "shutdownwithoutlogon"           = 0x1
    "undockwithoutlogon"             = 0x1
    "InactivityTimeoutSecs"          = 0x2D5
}

# Set string values
Set-ItemProperty -Path $basePath -Name "legalnoticecaption" -Value "" -Type String
Set-ItemProperty -Path $basePath -Name "legalnoticetext" -Value "" -Type String

# Set the DWORD values
foreach ($name in $registryValues.Keys) {
    Set-ItemProperty -Path $basePath -Name $name -Value $registryValues[$name] -Type DWord
}

# Create nested subkeys if needed
New-Item -Path "$basePath\Audit" -Force | Out-Null
New-Item -Path "$basePath\UIPI" -Force | Out-Null
New-Item -Path "$basePath\UIPI\Clipboard" -Force | Out-Null
New-Item -Path "$basePath\UIPI\Clipboard\ExceptionFormats" -Force | Out-Null

# ExceptionFormats values
$exceptionFormatsPath = "$basePath\UIPI\Clipboard\ExceptionFormats"
$exceptionValues = @{
    "CF_BITMAP"      = 0x2
    "CF_DIB"         = 0x8
    "CF_DIBV5"       = 0x11
    "CF_OEMTEXT"     = 0x7
    "CF_PALETTE"     = 0x9
    "CF_TEXT"        = 0x1
    "CF_UNICODETEXT" = 0xD
}

foreach ($name in $exceptionValues.Keys) {
    Set-ItemProperty -Path $exceptionFormatsPath -Name $name -Value $exceptionValues[$name] -Type DWord
}

Write-Output "Registry settings applied successfully."
