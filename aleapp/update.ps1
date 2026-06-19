$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\VERIFICATION.txt' = @{
            '(?i)(\s+URL:).*'      = "`${1} $($Latest.URL64)"
            '(?i)(\s+SHA256:).*' = "`${1} $($Latest.Checksum64)"
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
    $URL64 = $AssetsPage.Links.href | Where-Object { $_ -match 'aleapp[_-].*Windows_x64\.zip' }
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

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -FilenameBase "aleapp_Windows" -Purge
}

Update-Package -ChecksumFor 'none'