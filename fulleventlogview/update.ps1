$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\chocolateyinstall.ps1' = @{
            '(?i)(\s*checksum\s*=).*'   = "`${1} '$($Latest.Checksum32)'"
            '(?i)(\s*checksum64\s*=).*' = "`${1} '$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $DownloadPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.nirsoft.net/utils/full_event_log_view.html'

    @{
        Version = [regex]::Match($DownloadPage.Content, 'FullEventLogView v(\d+(?:\.\d+){0,3})').Groups[1].Value
    }
}

Update-Package
