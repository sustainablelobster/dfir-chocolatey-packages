$ErrorActionPreference = 'Stop'

$UbuntuFocalImageUrl = 'https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-wsl.rootfs.tar.gz'
$UbuntuFocalImageFileName = 'focal-server-cloudimg-amd64-wsl.rootfs.tar.gz'
Get-WebFile -Url $UbuntuFocalImageUrl -FileName $UbuntuFocalImageFileName

$UbuntuFocalSha256SumsUrl = 'https://cloud-images.ubuntu.com/focal/current/SHA256SUMS'
$UbuntuFocalSha256SumsFileName = 'SHA256SUMS'
Get-WebFile -Url $UbuntuFocalSha256SumsUrl -FileName $UbuntuFocalSha256SumsFileName

$UbuntuFocalImageSha256 = "$(Get-Content -Path $UbuntuFocalSha256SumsFileName | Select-String -SimpleMatch $UbuntuFocalImageFileName)".split(' ')[0]
Get-ChecksumValid -File $UbuntuFocalImageFileName -Checksum $UbuntuFocalImageSha256 -ChecksumType 'sha256'

$ToolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$SiftDir = Join-Path -Path $ToolsDir -ChildPath 'sift'
wsl --import SIFT "$SiftDir" "$UbuntuFocalImageFileName"

$SiftCliUrl = 'https://github.com/teamdfir/sift-cli/releases/download/v1.14.0-rc1/sift-cli-linux'
$SiftCliSigUrl = 'https://github.com/teamdfir/sift-cli/releases/download/v1.14.0-rc1/sift-cli-linux.sig'
$SiftCliPubUrl = 'https://github.com/teamdfir/sift-cli/releases/download/v1.14.0-rc1/sift-cli.pub'
wsl --distribution SIFT 'apt-get update'
wsl --distribution SIFT 'apt-get install -y cosign wget'
wsl --distribution SIFT "wget $SiftCliUrl"
wsl --distribution SIFT "wget $SiftCliSigUrl"
wsl --distribution SIFT "wget $SiftCliPubUrl"
wsl --distribution SIFT 'cosign verify-blob --key sift-cli.pub --signature sift-cli-linux.sig sift-cli-linux'
wsl --distribution SIFT 'mv sift-cli-linux /usr/local/bin/sift'
wsl --distribution SIFT 'chmod 755 /usr/local/bin/sift'
wsl --distribution SIFT 'sift install --mode=server'

Remove-Item -Path $UbuntuFocalImageFileName -Force
Remove-Item -Path $UbuntuFocalSha256SumsFileName -Force
