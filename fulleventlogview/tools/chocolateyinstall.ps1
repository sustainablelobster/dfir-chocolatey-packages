$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://www.nirsoft.net/utils/fulleventlogview.zip'
  url64bit      = 'https://www.nirsoft.net/utils/fulleventlogview-x64.zip'
  checksum      = 'b683bf400a967bd264d4f808c1c0269236a67bc853d8f222b7c71c25dff1b115'
  checksumType  = 'sha256'
  checksum64    = '020cb60e2e5a3f8b4d54d72bf45426516b74d194309115fbdf923aa159604b82'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
