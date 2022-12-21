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
    $DownloadsPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.opentext.com/products/tableau-download-center'
    $TimLink = ($DownloadsPage.Links | Where-Object -Property 'outerHTML' -Match 'Tableau Forensic Imager ((?:\d+\.?){0,3}\d+)')
    
    @{
        Version = $Matches[1]
        Url32 = $TimLink.href
    }
}

Update-Package -ChecksumFor '32'
