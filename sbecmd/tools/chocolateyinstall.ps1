$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://download.ericzimmermanstools.com/net6/SBECmd.zip'
  checksum      = '769c0c3548efa70f81748918a7cef017f106438e9fa516e1415450ce6310f451'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
