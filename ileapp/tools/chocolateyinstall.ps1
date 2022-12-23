$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$FileLocation = Join-Path $ToolsDir 'iLEAPP-windows.zip'
Get-ChocolateyUnzip $fileLocation $ToolsDir
$IleappGuiPath = (Get-ChildItem -Path $ToolsDir -Filter 'ileappGUI.exe' -Recurse).FullName
New-Item -Path ($IleappGuiPath + '.gui') -Type 'File'
Remove-Item -Path $fileLocation -Force
