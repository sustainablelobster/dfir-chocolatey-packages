
$ErrorActionPreference = 'Stop'

$ShortcutPath = "$env:USERPROFILE\Desktop\CyberChef.lnk"
if (Test-Path -Path $ShortcutPath) {
    Remove-Item -Path $ShortcutPath -Force
}
