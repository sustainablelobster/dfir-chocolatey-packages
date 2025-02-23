$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://download.ericzimmermanstools.com/net9/SBECmd.zip'
  checksum      = '797E31D3641EDE942DA2C338766587B69DCCD36D2FAA5DEEAA55C9D8174A1C4C'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
