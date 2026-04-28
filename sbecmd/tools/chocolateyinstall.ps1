$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://download.ericzimmermanstools.com/net9/SBECmd.zip'
  checksum      = '88edb98a32baaf68114aa106f25f999e46d387d9d0003d3222a1168cc1b7eb9b'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
