
$ErrorActionPreference = 'Stop' # stop on all errors

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$MegaUrl = 'https://mega.nz/file/3kRRxSZA#y98k7mBJKpygPxFu5Txi_-l9iDnyN3GzYxzjTVb3z-I'
$Sha256 = 'BD76AE4F98908B400C8BEAA676B862D953C4AA49853634E663EF1F2AC84069A1'
$ZipPath = '.\HibernationRecon.zip'

megatools.exe dl --path="$ZipPath" $MegaUrl
Get-ChecksumValid -File $ZipPath -Checksum $Sha256 -ChecksumType 'sha256'
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force
$GuiPath = (Get-ChildItem -Path $ToolsDir -Filter 'HibernationRecon.exe' -Recurse).FullName
New-Item -Path ($GuiPath + '.gui') -ItemType 'File' -Force
