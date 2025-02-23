$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\VERIFICATION.txt' = @{
            '(?i)(\s*URL:).*' = "`${1} $($Latest.URL32)"
            '(?i)(\s*SHA256:).*' = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $LatestReleasePage = Invoke-WebRequest -UseBasicParsing `
            -Uri 'https://raw.githack.com/EricZimmerman/ericzimmerman.github.io/master/index.md'
    if ($LatestReleasePage.Content -notmatch 'MFTECmd.*&vert;\s*\[([\d.]+)\]\((.*/net9/MFTECmd.zip)\)') {
        throw "Unable to find tool info"
    }

    @{
        Version = $Matches[1]
        URL32 = $Matches[2]
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor 'none'
