$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\chocolateyinstall.ps1' = @{
            '(?i)(\s*url\s*=).*' = "`${1} '$($Latest.Url32)'"
            '(?i)(\s*checksum\s*=).*' = "`${1} '$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $LatestReleasePage = Invoke-WebRequest -UseBasicParsing `
            -Uri 'https://raw.githack.com/EricZimmerman/ericzimmerman.github.io/master/index.md'
    if ($LatestReleasePage.Content -notmatch 'SBECmd.*&vert;\s*\[([\d.]+)\]\((.*/net9/SBECmd.zip)\)') {
        throw "Unable to find tool info"
    }

    @{
        Version = $Matches[1]
        URL32 = $Matches[2]
    }
}

Update-Package -ChecksumFor '32'
