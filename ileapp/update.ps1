$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\VERIFICATION.txt' = @{
            '(?i)(\s+URL32:).*'      = "`${1} $($Latest.URL32)"
            '(?i)(\s+Checksum32:).*' = "`${1} $($Latest.Checksum32)"
            '(?i)(\s+Get-RemoteChecksum).*' = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_GetLatest {
    $SavedProgressPreference = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'
    $LatestReleasePage = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/abrignoni/iLEAPP/releases/latest'
    if ($LatestReleasePage.Content -notmatch 'https://github\.com/abrignoni/iLEAPP/releases/expanded_assets/v?\.((?:\d+\.){0,3}\d+)') {
        throw "Unable to find assets page"
    }

    $AssetsUrl = $Matches[0]
    $Version = $Matches[1]

    $AssetsPage = Invoke-WebRequest -UseBasicParsing -Uri $AssetsUrl
    $ProgressPreference = $SavedProgressPreference
    $URL32 = $AssetsPage.Links.href | Where-Object { $_ -match 'iLEAPP-windows\.zip' }
    if ($null -eq $URL32) {
        throw "Unable to find zip URL"
    }
    if ($URL32 -notmatch '^https://github\.com') {
        $URL32 = 'https://github.com' + $URL32
    }

    @{
        Version = $Version
        URL32 = $URL32
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor 'none'