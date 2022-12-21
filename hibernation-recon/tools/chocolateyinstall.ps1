
$ErrorActionPreference = 'Stop' # stop on all errors

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$MegaUrl = 'https://mega.nz/file/PowEiY4S#2T087NqeVypCD77MmINi7jEoDKOPsVpnRMwQJKXQZys'
$Sha256 = '60BB6C8C6F24FDBBBB2A3EAA1F9601F21ED36327F57735FE3E8F3E25C6619AD6'
$ZipPath = '.\HibernationRecon.zip'

megatools.exe dl --path="$ZipPath" $MegaUrl
Get-ChecksumValid -File $ZipPath -Checksum $Sha256 -ChecksumType 'sha256'
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force
$GuiPath = (Get-ChildItem -Path $ToolsDir -Filter 'HibernationRecon.exe' -Recurse).FullName
New-Item -Path ($GuiPath + '.gui') -ItemType 'File' -Force
