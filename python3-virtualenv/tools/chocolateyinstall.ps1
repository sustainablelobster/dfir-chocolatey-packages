$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$WheelPath = (Get-ChildItem -Path $ToolsDir -Filter 'virtualenv*.whl').FullName
pip3 install --quiet $WheelPath
