
$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Join-Path $toolsDir 'ALEAPP-windows.zip'
Get-ChocolateyUnzip $fileLocation $toolsDir
$aleappGuiPath = (Get-ChildItem -Path $toolsDir -Filter 'aleappGUI.exe' -Recurse).FullName
New-Item -Path ($aleappGuiPath + '.gui') -Type 'File'
Remove-Item -Path $fileLocation -Force
