$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipPath = (Get-ChildItem -Path $ToolsDir -Filter 'RegistryExplorer.zip').FullName
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force
$ExePath = (Get-ChildItem -Path $ToolsDir -Filter 'RegistryExplorer.exe' -Recurse).FullName
New-Item -Path ($ExePath + '.gui') -Type 'File'
