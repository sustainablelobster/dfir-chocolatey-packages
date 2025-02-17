$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'MSI'
    url            = 'https://mimage.opentext.com/support/ecm/tableau/setup_tableau_imager_20.3.msi'
    softwareName   = 'Tableau Imager*'
    checksum       = 'c4dbffc9737ba012925db7181738c7747e69ec853520acb0f70c95f17394ff1d'
    checksumType   = 'sha256'
    silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
    validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
