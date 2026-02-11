$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\VERIFICATION.txt' = @{
            '(?i)(\s*32-bit URL:).*' = "`${1} $($Latest.URL32)"
            '(?i)(\s*32-bit SHA256:).*' = "`${1} $($Latest.Checksum32)"
            '(?i)(\s*64-bit URL:).*' = "`${1} $($Latest.URL64)"
            '(?i)(\s*64-bit SHA256:).*' = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {
    $LatestReleasePage = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/codeyourweb/fastfinder/releases/latest'
    if ($LatestReleasePage.Content -notmatch 'https://github\.com/codeyourweb/fastfinder/releases/expanded_assets/v?([\d.]+)') {
        throw "Unable to find assets page"
    }

    $AssetsUrl = $Matches[0]
    $Version = $Matches[1]
    $AssetsPage = Invoke-WebRequest -UseBasicParsing -Uri $AssetsUrl

    $URL32 = $AssetsPage.Links.href | Where-Object { $_ -match 'fastfinder-windows-386.exe' }
    if ($null -eq $URL32) {
        throw "Unable to find 32-bit exe URL"
    }
    if ($URL32 -notmatch '^https://github\.com') {
        $URL32 = 'https://github.com' + $URL32
    }

    $URL64 = $AssetsPage.Links.href | Where-Object { $_ -match 'fastfinder-windows-amd64.exe' }
    if ($null -eq $URL64) {
        throw "Unable to find 64-bit exe URL"
    }
    if ($URL64 -notmatch '^https://github\.com') {
        $URL64 = 'https://github.com' + $URL64
    }

    @{
        Version = $Version
        URL32 = $URL32
        URL64 = $URL64
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
    Rename-Item -Path '.\tools\fastfinder-windows-386.exe' -NewName 'fastfinder.exe'
    Rename-Item -Path '.\tools\fastfinder-windows-amd64.exe' -NewName 'fastfinder64.exe'
}

Update-Package -ChecksumFor 'none'
