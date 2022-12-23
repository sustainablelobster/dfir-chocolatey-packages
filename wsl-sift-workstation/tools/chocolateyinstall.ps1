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
'Importing WSL image...'
wsl --import SIFT "$SiftDir" "$UbuntuFocalImageFileName"
wsl --distribution SIFT apt-get update

$CosignDebUrl = 'https://github.com/sigstore/cosign/releases/download/v1.13.1/cosign_1.13.1_amd64.deb'
$CosignDebFileName = 'cosign.deb'
$CosignDebSha256 = '0aea3725c96f9f80a4d4e0a3d05127044fbc6cf53ce341b16eb03dff78da1b34'
Get-WebFile -Url $CosignDebUrl -FileName $CosignDebFileName
Get-ChecksumValid -File $CosignDebFileName -Checksum $CosignDebSha256 -ChecksumType 'sha256'
wsl --distribution SIFT dpkg -i $CosignDebFileName

$SiftCliUrl = 'https://github.com/teamdfir/sift-cli/releases/download/v1.14.0-rc1/sift-cli-linux'
$SiftCliFileName = 'sift-cli-linux'
Get-WebFile -Url $SiftCliUrl -FileName $SiftCliFileName
$SiftCliSigUrl = 'https://github.com/teamdfir/sift-cli/releases/download/v1.14.0-rc1/sift-cli-linux.sig'
$SiftCliSigFileName = 'sift-cli-linux.sig'
Get-WebFile -Url $SiftCliSigUrl -FileName $SiftCliSigFileName
$SiftCliPubUrl = 'https://github.com/teamdfir/sift-cli/releases/download/v1.14.0-rc1/sift-cli.pub'
$SiftCliPubFileName = 'sift-cli.pub'
Get-WebFile -Url $SiftCliPubUrl -FileName $SiftCliPubFileName
wsl --distribution SIFT sh -c "cosign verify-blob --key $SiftCliPubFileName --signature $SiftCliSigFileName $SiftCliFileName 2> /dev/null"
if (-not $?) {
    throw 'Could not verify sift-cli-linux!'
}
wsl --distribution SIFT mv $SiftCliFileName /usr/local/bin/sift
wsl --distribution SIFT chmod 755 /usr/local/bin/sift

$SiftUser = 'sansforensics'
$SiftPassword = 'forensics'
wsl --distribution SIFT useradd -G adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev -m -s /usr/bin/bash $SiftUser
wsl --distribution SIFT sh -c "echo '${SiftUser}:${SiftPassword}' | chpasswd"
wsl --distribution SIFT cp /etc/sudoers /etc/sudoers.bak
wsl --distribution SIFT sh -c "echo '$SiftUser ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"
wsl --distribution SIFT --user $SiftUser sudo sift install --mode=server
if (-not $?) {
    throw 'Failed to install sift!'
}

wsl --distribution SIFT mv /etc/sudoers.bak /etc/sudoers
wsl --distribution SIFT sh -c "echo -e '[user]\ndefault=$SiftUser' >> /etc/wsl.conf"
wsl --terminate SIFT

Remove-Item -Path $UbuntuFocalImageFileName -Force
Remove-Item -Path $UbuntuFocalSha256SumsFileName -Force
Remove-Item -Path $ConsoleFileName -Force
Remove-Item -Path $SiftCliPubFileName -Force
Remove-Item -Path $SiftCliSigFileName -Force
