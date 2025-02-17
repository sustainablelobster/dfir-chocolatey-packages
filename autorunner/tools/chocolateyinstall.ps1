$ErrorActionPreference = 'Stop'

$OSArchitectureWidth = Get-OSArchitectureWidth
if ($OSArchitectureWidth -ne 64) {
    throw "$OSArchitectureWidth-bit architecture not supported."
}

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
    PackageName    = $env:ChocolateyPackageName
    UnzipLocation  = $ToolsDir
    Url64bit       = 'https://github.com/woanware/autorunner/releases/download/v0.0.16/autorunner.v0.0.16.zip'
    Checksum64     = 'ad4cdf61cf7e2ab77e78cc425788e526d02e2149ea1965bf870c0558700c77eb'
    ChecksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
$SigcheckPath = (Get-Command -Name 'sigcheck64.exe').Path
$SigcheckSymlinkPath = Join-Path -Path $ToolsDir -ChildPath 'Tools\sigcheck.exe'
cmd.exe /C mklink "$SigcheckSymlinkPath" "$SigcheckPath" # Can't use "New-Item -ItemType 'SymbolicLink'" in test enviroment
