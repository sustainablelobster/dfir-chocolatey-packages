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
    $PyPiPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://pypi.org/project/virtualenv/#files'
    $WheelLink = $PyPiPage.Links | Where-Object -Property 'Href' -Match 'virtualenv-((?:\d+\.){0,3}\d+).*-py3-none-any.whl'
    
    $Version = $Matches[1]
    if (-not $Version) {
        throw 'Failed to find version'
    }

    $URL32 = $WheelLink.Href
    if (-not $URL32) {
        throw 'Failed to get URL'
    }

    @{
        Version = $Version
        URL32 = $URL32
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix
}

Update-Package -ChecksumFor 'none'
