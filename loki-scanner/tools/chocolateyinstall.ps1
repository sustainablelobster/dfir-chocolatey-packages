$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipPath = (Get-ChildItem -Path $ToolsDir -Filter 'loki_*.zip').FullName
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force

$IgnorableExes = (Get-ChildItem -Path $ToolsDir -Filter '*.exe' -Exclude 'loki*' -Recurse).FullName
foreach ($Exe in $IgnorableExes) {
  New-Item -Path "$Exe.ignore" -ItemType 'File'
}
