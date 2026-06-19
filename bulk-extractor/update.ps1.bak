$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\VERIFICATION.txt' = @{
            '(?i)bulk_extractor-.*-windowsinstaller\.exe' = "$($Latest.URL32.split('/')[-1])"
            '(?i)(\s*SHA256:).*' = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $DownloadPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://downloads.digitalcorpora.org/downloads/bulk_extractor/'
    $URL32 = ($DownloadPage.Links | Where-Object -Property 'href' -Match 'bulk_extractor-(\d+(?:\.\d+)+)-windowsinstaller.exe')[-1].href
    $Version = $Matches[1]

    @{
        Version = $Version
        URL32 = $URL32
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor 'none'
