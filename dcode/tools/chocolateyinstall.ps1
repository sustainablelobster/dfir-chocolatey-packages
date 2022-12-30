$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipPackageArgs = @{
    PackageName   = $env:ChocolateyPackageName
    UnzipLocation = $ToolsDir
    Url           = 'https://www.digital-detective.net/download/download.php?downcode=ae2znu5994j1lforlh03'
    Checksum      = 'dbb23d6ea4f572fbaec017fb8acc2a8b62b74fafa81ea4a388966ec14087a9e4'
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
