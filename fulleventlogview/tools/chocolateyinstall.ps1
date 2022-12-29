$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://www.nirsoft.net/utils/fulleventlogview.zip'
  url64bit      = 'https://www.nirsoft.net/utils/fulleventlogview-x64.zip'
  checksum      = '839bd243b6aee06ae77fe9bc1a5249f788f1def99a6e97fd02f9084b9ec9452c'
  checksumType  = 'sha256'
  checksum64    = 'f9f6f75fc7bd3968a28ef969e715224f1a875ccd0bf1454ef8cfbce395f03501'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
