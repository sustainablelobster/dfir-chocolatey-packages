$ErrorActionPreference = 'Stop'

$OSArchitectureWidth = Get-OSArchitectureWidth
if ($OSArchitectureWidth -ne 64) {
    throw "$OSArchitectureWidth-bit architecture not supported."
}

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$FileLocation = Join-Path $ToolsDir 'Arsenal-Image-Mounter.zip'
Get-ChocolateyUnzip $FileLocation $ToolsDir
$AimGuiPath = (Get-ChildItem -Path $ToolsDir -Filter 'ArsenalImageMounter.exe' -Recurse).FullName
New-Item -Path ($AimGuiPath + '.gui') -Type 'File'
Remove-Item -Path $FileLocation -Force
