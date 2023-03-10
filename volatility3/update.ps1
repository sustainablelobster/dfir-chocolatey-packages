$ErrorActionPreference = 'Stop'
Import-Module -Name 'au'

function global:au_SearchReplace {
    @{
        '.\volatility3.nuspec' = @{
            '^\s*<dependency id="python3" version=".+" />\s*$' = "      <dependency id=`"python3`" version=`"$($Latest.PythonVersion)`" />"
        }
    }
}

function global:au_GetLatest {
    $PyPiPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://pypi.org/project/volatility3'
    
    if ($PyPiPage.Content -notmatch 'volatility3\s+(\d+(?:\.\d+){0,3})') {
        throw 'Failed to find version'
    }
    $Version = $Matches[1]

    if ($PyPiPage.Content -notmatch 'Python (?:&gt;|=)=(3(?:\.\d+){0,3})') {
        throw 'Failed to find required Python version'
    }
    $PythonVersion = $Matches[1]
    
    @{
        Version = $Version
        PythonVersion = $PythonVersion
    }
}

Update-Package -ChecksumFor 'none'
