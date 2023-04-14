$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://www.nirsoft.net/utils/fulleventlogview.zip'
  url64bit      = 'https://www.nirsoft.net/utils/fulleventlogview-x64.zip'
  checksum      = '3647f159fe0033ea4f9827fd276665b439906ea21fccb6a785b2b2974b874bdc'
  checksumType  = 'sha256'
  checksum64    = '872ecf4c4c92033be433217a158130255683c6612069792d103a2cc68ab2bdef'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
