Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\VERIFICATION.txt' = @{
            '(?i)(\s*hindsight\.exe URL:).*'      = "`${1} $($Latest.HindsightURL)"
            '(?i)(\s*hindsight_gui\.exe URL:).*' = "`${1} $($Latest.HindsightGuiURL)"
            '(?i)(\s*hindsight\.exe SHA256:).*' = "`${1} $($Latest.HindsightSHA256)"
            '(?i)(\s*hindsight_gui\.exe SHA256:).*' = "`${1} $($Latest.HindsightGuiSHA256)"
        }
    }
}

function global:au_GetLatest {
    $LatestReleasePage = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/obsidianforensics/hindsight/releases/latest'
    if ($LatestReleasePage.Content -notmatch 'https://github\.com/obsidianforensics/hindsight/releases/expanded_assets/v?([\d.]+)') {
        throw "Unable to find assets page"
    }

    $AssetsUrl = $Matches[0]
    $Version = $Matches[1]

    $AssetsPage = Invoke-WebRequest -UseBasicParsing -Uri $AssetsUrl
    $HindsightURL = $AssetsPage.Links.href | Where-Object { $_ -match 'hindsight\.exe' }
    if ($null -eq $HindsightURL) {
        throw "Unable to find hindsight.exe URL"
    }
    if ($HindsightURL -notmatch '^https://github\.com') {
        $HindsightURL = 'https://github.com' + $HindsightURL
    }

    $HindsightGuiURL = $AssetsPage.Links.href | Where-Object { $_ -match 'hindsight_gui\.exe' }
    if ($null -eq $HindsightGuiURL) {
        throw "Unable to find hindsight.exe URL"
    }
    if ($HindsightGuiURL -notmatch '^https://github\.com') {
        $HindsightGuiURL = 'https://github.com' + $HindsightGuiURL
    }

    @{
        Version = $Version
        HindsightURL = $HindsightURL
        HindsightGuiURL = $HindsightGuiURL
        FileType = 'exe'
    }
}

function global:au_BeforeUpdate {
    $Latest.URL32 = $Latest.HindsightURL
    $Latest.URL64 = $Latest.HindsightGuiURL
    Get-RemoteFiles -NoSuffix -Purge
    $Latest.HindsightSHA256 = $Latest.Checksum32
    $Latest.HindsightGuiSHA256 = $Latest.Checksum64
}

Update-Package
