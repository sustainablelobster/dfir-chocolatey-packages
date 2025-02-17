$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$Vol3VenvPath = Join-Path -Path $ToolsDir -ChildPath 'vol3_virtualenv'
python -m virtualenv "$Vol3VenvPath"
$Vol3VenvActivator = Join-Path -Path $Vol3VenvPath -ChildPath 'Scripts\activate.ps1'
. $Vol3VenvActivator
pip install --disable-pip-version-check volatility3==$env:ChocolateyPackageVersion
deactivate
$IgnorableExes = (Get-ChildItem -Path $Vol3VenvPath -Filter '*.exe' -Exclude 'vol*' -Recurse).FullName
foreach ($Exe in $IgnorableExes) {
    New-Item -Path "$Exe.ignore" -ItemType 'File'
}
