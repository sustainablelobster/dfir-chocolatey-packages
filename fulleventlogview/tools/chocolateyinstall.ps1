$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://www.nirsoft.net/utils/fulleventlogview.zip'
  url64bit      = 'https://www.nirsoft.net/utils/fulleventlogview-x64.zip'
  checksum      = '49023dd20359187671e76693f6bc4175c2c54cdef1503b4f64953e4761b79397'
  checksumType  = 'sha256'
  checksum64    = '0e408f33c8d06a02b4baa1b0866f993e1376d0cbbb90a33b0528a832fad29bee'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
