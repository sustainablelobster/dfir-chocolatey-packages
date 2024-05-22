$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

$NUSPEC_PATH = '.\ericzimmermantools.nuspec'

function global:au_SearchReplace {
    $Replacements = @{}

    foreach ($Dependency in $Latest.Dependencies) {
        $Replacements."(\<dependency .+?`"$($Dependency.id)`" version=)`"([^`"]+)`"" = `
                "`$1`"$($Dependency.version)`""
    }

    @{
        "$($Latest.PackageName).nuspec" = $Replacements
    }
}

function global:au_GetLatest {
    [xml] $Nuspec = Get-Content -Path $NUSPEC_PATH
    $NuspecVersion = $Nuspec.package.metadata.version
    $Dependencies = $Nuspec.package.metadata.dependencies.dependency
    $DoUpdate = $false

    foreach ($Dependency in $Dependencies) {
        $Selection = choco.exe info $Dependency.id | Select-String -Pattern "$($Dependency.id) ([\d.]+)"

        try {
            $Version = $Selection.Matches.Groups[1].Value
        } catch [System.Management.Automation.RuntimeException] {
            continue
        }
        
        if ($Dependency.version -ne $Version) {
            $Dependency.version = $Version
            $DoUpdate = $true
        }
    }

    if ($DoUpdate) {
        [version] $Ver = $NuspecVersion
        $NuspecVersion = "$($Ver.Major).$($Ver.Minor).$($Ver.Build).$($Ver.Revision + 1)"
    }

    @{
        Version = $NuspecVersion
        Dependencies = $Dependencies
    }
}

Update-Package
