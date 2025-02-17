$ErrorActionPreference = 'Stop'

$ZipFile = Join-Path -Path $env:TEMP -ChildPath 'DCode-x86-EN-5.6.24123.1.zip'
$Installer = Join-Path -Path $env:TEMP -ChildPath 'DCode-x86-EN-5.6.24123.1.exe'

# Using Invoke-WebRequest because Get-ChocolateyWebFile fails for this site
$SavedProgressPreference = $ProgressPreference
$ProgressPreference = 'SilentlyContinue'
$WebRequestArgs = @{
    UseBasicParsing = $true
    Uri = 'https://www.digital-detective.net/download/download.php?downcode=ae2znu5994j1lforlh03'
    OutFile = $ZipFile
}
Invoke-WebRequest @WebRequestArgs
$ProgressPreference = $SavedProgressPreference

$ChecksumValidArgs = @{
    File = $ZipFile
    Checksum = '9ffe1106ee9d9f55b53d5707621d5990f493604e20f3dbdb0d22ec1b8ecb2458'
    ChecksumType = 'sha256'
}
Get-ChecksumValid @ChecksumValidArgs

Get-ChocolateyUnzip -FileFullPath $ZipFile -Destination $env:TEMP

$InstallPackageArgs = @{
  PackageName = $env:ChocolateyPackageName
  FileType = 'EXE'
  File = $Installer
  SoftwareName = 'Digital Detective DCode*'
  SilentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  ValidExitCodes = @(0)
}
Install-ChocolateyInstallPackage @InstallPackageArgs

Remove-Item -Path $Installer -Force
Remove-Item -Path $ZipFile -Force
