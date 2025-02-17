$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\VERIFICATION.txt' = @{
            '(?i)(\s+URL:).*'      = "`${1} $($Latest.URL32)"
            '(?i)(\s+SHA256:).*' = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $SavedProgressPreference = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'
    $LatestReleasePage = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/abrignoni/ALEAPP/releases/latest'
    if ($LatestReleasePage.Content -notmatch 'https://github\.com/abrignoni/ALEAPP/releases/expanded_assets/v?([\d.]+)') {
        throw "Unable to find assets page"
    }

    $AssetsUrl = $Matches[0]
    $Version = $Matches[1]

    $AssetsPage = Invoke-WebRequest -UseBasicParsing -Uri $AssetsUrl
    $ProgressPreference = $SavedProgressPreference
    $URL32 = $AssetsPage.Links.href | Where-Object { $_ -match 'aleapp[_-].*Windows\.zip' }
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
    Get-RemoteFiles -NoSuffix -FilenameBase "aleapp_Windows" -Purge
}

Update-Package -ChecksumFor 'none'