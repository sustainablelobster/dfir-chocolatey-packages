$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://www.nirsoft.net/utils/fulleventlogview.zip'
  url64bit      = 'https://www.nirsoft.net/utils/fulleventlogview-x64.zip'
  checksum      = '3f53042d735df9a168050e4e0254d02638de14bb55131253eca3a0ccdf328159'
  checksumType  = 'sha256'
  checksum64    = '4a04355cbe240a35727c7a3f5f779217b1487c358673899d85d395360dc0790e'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
