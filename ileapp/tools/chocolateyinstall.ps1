﻿$ErrorActionPreference = 'Stop'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ZipPath = (Get-ChildItem -Path $ToolsDir -Filter 'ileapp_Windows.zip').FullName
Get-ChocolateyUnzip -FileFullPath $ZipPath -Destination $ToolsDir
Remove-Item -Path $ZipPath -Force