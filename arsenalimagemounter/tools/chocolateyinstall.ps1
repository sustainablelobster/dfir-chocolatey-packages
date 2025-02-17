$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipPath = Join-Path -Path $ToolsDir -ChildPath 'Arsenal-Image-Mounter.zip'
Get-ChocolateyUnzip -FileFullPath64 $ZipPath -Destination $ToolsDir
$AimGuiPath = (Get-ChildItem -Path $ToolsDir -Filter 'ArsenalImageMounter.exe' -Recurse).FullName
New-Item -Path ($AimGuiPath + '.gui') -Type 'File'
Remove-Item -Path $ZipPath -Force
