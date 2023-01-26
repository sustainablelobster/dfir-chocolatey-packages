
$ErrorActionPreference = 'Stop' # stop on all errors

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$MegaUrl = 'https://mega.nz/file/z4Q2iD4C#1I8eFUnuV-x-OOuFJ7G-8YWcNPDfrV26w3aL2mnqGPI'
$Sha256 = 'DE71FB354E5D9A6193C165F18D775819F1277014A7317371CDEC14060857F606'
$ZipPath = '.\HibernationRecon.zip'

megatools.exe dl --path="$ZipPath" $MegaUrl
Get-ChecksumValid -File $ZipPath -Checksum $Sha256 -ChecksumType 'sha256'
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force
$GuiPath = (Get-ChildItem -Path $ToolsDir -Filter 'HibernationRecon.exe' -Recurse).FullName
New-Item -Path ($GuiPath + '.gui') -ItemType 'File' -Force
