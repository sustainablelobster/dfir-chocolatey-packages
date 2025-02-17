$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Bulk Extractor*'
  fileType      = 'EXE'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % {
    $packageArgs['file'] = "$($_.UninstallString)"

    if ($packageArgs['fileType'] -eq 'MSI') {
      $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
      $packageArgs['file'] = ''
    } else {
      # pass
    }

    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}

do {
  Start-Sleep -Milliseconds 100
  $UninstallWindowTitle = (Get-Process | Where-Object -Property 'MainWindowTitle' -Match 'Bulk Extractor.*Uninstall').MainWindowTitle
} while (-not $UninstallWindowTitle)

$WShell = New-Object -ComObject 'wscript.shell'
$WShell.AppActivate($UninstallWindowTitle)
Start-Sleep -Milliseconds 100
$WShell.SendKeys('~')
