$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipPath = (Get-ChildItem -Path $ToolsDir -Filter 'UsnJrnl2Csv_*.zip').FullName
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force

if (Get-OSArchitectureWidth -Compare 64) {
  New-Item -Path "$ToolsDir\UsnJrnl2Csv64.exe.gui" -ItemType 'File'
} else {
  New-Item -Path "$ToolsDir\UsnJrnl2Csv64.exe.ignore" -ItemType 'File'
}
