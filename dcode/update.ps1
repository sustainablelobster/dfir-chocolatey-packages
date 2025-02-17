$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\chocolateyinstall.ps1' = @{
            '(DCode-x86-EN-)[\d\.]+\d' = "`${1}$($Latest.Version)"
            '(?i)(\s*URI\s*=).*' = "`${1} '$($Latest.URL32)'"
            '(?i)(\s*Checksum\s*=).*' = "`${1} '$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $DownloadPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.digital-detective.net/dcode/'
    $Version = [regex]::Match($DownloadPage.Content, 'DCode-x86-EN-([\d\.]+).exe').Groups[1].Value
    $URL32 = $DownloadPage.Links.href | Where-Object { $_ -Match 'download\.php' }

    @{
        Version = $Version
        URL32 = $URL32
    }
}

Update-Package -ChecksumFor '32'
