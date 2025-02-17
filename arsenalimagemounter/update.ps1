$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\VERIFICATION.txt' = @{
            '(?i)(\s+Checksum64:).*' = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {
    $DownloadsPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://arsenalrecon.com/downloads'
    $MegaLink = ($DownloadsPage.Links | Where-Object -Property 'href' -Match 'https://mega.nz/file/')[0]

    @{
        Version = [regex]::Match($MegaLink.outerHTML, 'v((?:\d+.){1,3}\d+)').Groups[1].Value
        MegaUrl = $MegaLink.href
    }
}

function global:au_BeforeUpdate {
    $ZipPath = '.\tools\Arsenal-Image-Mounter.zip'
    $TempPath = $ZipPath + '.tmp'
    megatools dl --no-progress --path="$TempPath" $Latest.MegaUrl
    Move-Item -Path $TempPath -Destination $ZipPath -Force
    $Latest.Checksum64 = (Get-FileHash -Path $ZipPath -Algorithm 'SHA256').Hash
}

Update-Package -ChecksumFor 'none'
