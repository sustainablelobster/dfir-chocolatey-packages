$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\chocolateyinstall.ps1' = @{
            '(?i)(\s*Url64bit\s*=).*' = "`${1} '$($Latest.URL64)'"
            '(?i)(\s*Checksum64\s*=).*' = "`${1} '$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $LatestReleasePage = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/woanware/autorunner/releases/latest'
    if ($LatestReleasePage.Content -notmatch 'https://github.com/woanware/autorunner/releases/expanded_assets/v?([\d.]+)') {
        throw "Unable to find assets page"
    }
    $AssetsUrl = $Matches[0]
    $Version = $Matches[1]

    $AssetsPage = Invoke-WebRequest -UseBasicParsing -Uri $AssetsUrl
    $URL64 = $AssetsPage.Links.href | Where-Object { $_ -match 'autorunner\.v.*.zip' }
    if ($null -eq $URL64) {
        throw "Unable to find zip URL"
    }
    if ($URL64 -notmatch '^https://github\.com') {
        $URL64 = 'https://github.com' + $URL64
    }

    @{
        Version = $Version
        URL64 = $URL64
    }
}

Update-Package -ChecksumFor '64'