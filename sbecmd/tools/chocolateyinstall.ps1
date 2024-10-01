$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://download.ericzimmermanstools.com/net6/SBECmd.zip'
  checksum      = '76e68ea696cb94f3a26c5c05e01467bdd8e18503fabd55ce4065448251071595'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
