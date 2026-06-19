
$ErrorActionPreference = 'Stop' # stop on all errors

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$MegaUrl = 'https://mega.nz/file/S0AShJZC#0bAnvlQOJBZMbtOHfyN_5jrZXcimfImae4zpY6O220w'
$Sha256 = 'A7196907ADB7A4FA110CAB65CED57E4024F1162A051CD7D0DCE1ABF3CEC998B6'
$ZipPath = '.\HibernationRecon.zip'

megatools.exe dl --path="$ZipPath" $MegaUrl
Get-ChecksumValid -File $ZipPath -Checksum $Sha256 -ChecksumType 'sha256'
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force
$GuiPath = (Get-ChildItem -Path $ToolsDir -Filter 'HibernationRecon.exe' -Recurse).FullName
New-Item -Path ($GuiPath + '.gui') -ItemType 'File' -Force
