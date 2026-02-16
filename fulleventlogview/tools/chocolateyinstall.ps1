$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://www.nirsoft.net/utils/fulleventlogview.zip'
  url64bit      = 'https://www.nirsoft.net/utils/fulleventlogview-x64.zip'
  checksum      = '1a9748e122bf48bbffa25c316851756150d41c886ab3b5a50a52b969a190afa2'
  checksumType  = 'sha256'
  checksum64    = 'dd67610f19a4fffe77460f55ebb318523cc8bcbcb8fc3d462ee0dffab4ba1d95'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
