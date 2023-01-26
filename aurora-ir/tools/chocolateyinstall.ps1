$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipPath = (Get-ChildItem -Path $ToolsDir -Filter 'Aurora-win32-x64*.zip').FullName
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force
$AuroraPath = (Get-ChildItem -Path $ToolsDir -Filter 'Aurora.exe' -Recurse).FullName
New-Item -Path ($AuroraPath + '.gui') -Type 'File'
