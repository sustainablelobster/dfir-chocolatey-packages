$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{}
}

function global:au_GetLatest {
    $PyPiPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://pypi.org/simple/volatility3'
    $LatestSource = ($PyPiPage.Links.href | Where-Object { $_ -match 'tar\.gz' })[-1]
    
    if ($LatestSource -notmatch 'volatility3-(\d+(?:\.\d+){0,3})') {
        throw 'Failed to find version'
    }
    $Version = $Matches[1]
    
    @{
        Version = $Version
    }
}

Update-Package -ChecksumFor 'none'
