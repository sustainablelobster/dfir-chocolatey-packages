$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipPackageArgs = @{
    PackageName   = $env:ChocolateyPackageName
    UnzipLocation = $ToolsDir
    Url           = 'https://www.digital-detective.net/download/download.php?downcode=ae2znu5994j1lforlh03'
    Checksum      = '9ffe1106ee9d9f55b53d5707621d5990f493604e20f3dbdb0d22ec1b8ecb2458'
    ChecksumType  = 'sha256'
}
Install-ChocolateyZipPackage @ZipPackageArgs

$InstallerPath = (Get-ChildItem -Path $ToolsDir -Filter 'DCode*.exe' -Recurse).FullName
$InstallPackageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = $InstallerPath
  softwareName  = 'Digital Detective DCode*'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}
Install-ChocolateyInstallPackage @InstallPackageArgs
Remove-Item -Path $InstallerPath -Force
