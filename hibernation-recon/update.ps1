$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\tools\chocolateyinstall.ps1' = @{
            '(?i)(\$MegaUrl\s*=).*' = "`${1} '$($Latest.MegaUrl)'"
            '(?i)(\$Sha256\s*=).*' = "`${1} '$($Latest.Sha256)'"
        }
    }
}

function global:au_GetLatest {
    $DownloadsPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://arsenalrecon.com/downloads'
    $MegaLink = ($DownloadsPage.Links | Where-Object -Property 'href' -Match 'https://mega.nz/file/')[1]

    @{
        Version = [regex]::Match($MegaLink.outerHTML, 'v((?:\d+.){1,3}\d+)').Groups[1].Value
        MegaUrl = $MegaLink.href
    }
}

function global:au_BeforeUpdate {
    $ZipPath = '.\Hibernation-Recon.zip'
    megatools dl --no-progress --path="$ZipPath" $Latest.MegaUrl
    $Latest.Sha256 = (Get-FileHash -Path $ZipPath -Algorithm 'SHA256').Hash
    Remove-Item -Path $ZipPath -Force
}

Update-Package -ChecksumFor 'none'
