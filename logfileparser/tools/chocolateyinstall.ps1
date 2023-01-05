$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipPath = (Get-ChildItem -Path $ToolsDir -Filter 'LogFileParser_*.zip').FullName
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force

if (Get-OSArchitectureWidth -Compare 64) {
  New-Item -Path "$ToolsDir\LogFileParser64.exe.gui" -ItemType 'File'
} else {
  New-Item -Path "$ToolsDir\LogFileParser64.exe.ignore" -ItemType 'File'
}
