$ErrorActionPreference = 'Stop'

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = (Get-ChildItem -Path $toolsDir -Filter 'bulk_extractor*.exe').FullName
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  file          = $fileLocation
  softwareName  = 'Bulk Extractor*'
  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs
