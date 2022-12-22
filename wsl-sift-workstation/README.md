# SIFT Workstation

The SIFT Workstation is a collection of free and open-source incident response and forensic tools designed to perform detailed digital forensic examinations in a variety of settings. It can match any current incident response and forensic tool suite. SIFT demonstrates that advanced incident response capabilities and deep-dive digital forensic techniques can be accomplished using cutting-edge open-source tools that are freely available and frequently updated.

NOTE: This Chocolatey package's version number is derived from the [SIFT CLI](https://github.com/teamdfir/sift-cli) version, because SIFT Workstation does not feature version numbers. SIFT CLI is the official tool for managing a SIFT Workstation installation.

## Who Created the SIFT?

Rob Lee created the original SIFT Workstation in 2007 to support forensic analysis in the SANS FOR508 class. Over the years, he and a small team have continually updated the SIFT Workstation for use in class, as well as for the wider community as a public resource. With over 125,000 downloads to date, the SIFT Workstation continues to be one of the most popular open-source incident-response and digital forensic offerings available.

## Key new SIFT Workstation features include:

- Ubuntu LTS 20.04 Base
- 64-bit base system
- Better memory utilization
- Auto-DFIR package update and customizations
- Latest forensic tools and techniques
- VM Appliance ready to tackle forensics
- Cross compatibility between Linux and Windows
- Option to install/upgrade stand-alone system via SIFT-CLI installer
- Expanded Filesystem Support

## SIFT Workstation Capabilities

A key tool during incident response, helping incident responders identify and contain advanced threat groups. The SIFT Workstation provides robust capabilities for analyzing file systems, network evidence, memory images, and more.

**File system support**
- NTFS (NTFS)
- iso9660 (ISO9660 CD)
- hfs (HFS+)
- raw (Raw Data)
- swap (Swap Space)
- memory (RAM Data)
- fat12 (FAT12)
- fat16 (FAT16)
- fat32 (FAT32)
- ext2 (EXT2)
- ext3 (EXT3)
- ext4 (EXT4)
- ufs1 (UFS1)
- ufs2 (UFS2)

**Evidence Image Support**
- raw (Single raw file (dd))
- aff (Advanced Forensic Format)
- afd (AFF Multiple File)
- afm (AFF with external metadata)
- afflib (All AFFLIB image formats (including beta ones))
- ewf (Expert Witness format (encase))
- split raw (Split raw files) via affuse
- affuse - mount 001 image/split images to view single raw file and metadata
- split ewf (Split E01 files) via mount_ewf.py
- mount_ewf.py - mount E01 image/split images to view single raw file and metadata
- ewfmount - mount E01 images/split images to view single raw file and metadata
- vmdk
- vhd/vhdx
- qcow

**Incident Response Support**
- F-Response Tool Suite Compatible
- Rapid Scripting and Analysis
- Threat Intelligence and Indicator of Compromise Support
- Threat Hunting and Malware Analysis Capabilities

**Software Includes:**
- Plaso/log2timeline (Timeline Generation Tool)
- Rekall Framework (Memory Analysis)
- Volatility Framework (Memory Analysis)
- 3rd Party Volatility Plugins
- bulk_extractor
- afflib
- afflib-tools
- ClamAV
- dc3dd
- imagemounter
- libbde
- libesedb
- libevt
- libevtx
- libewf
- libewf-tools
- libewf-python
- libfvde
- libvshadow
- lightgrep
- Qemu
- regripper and plugins
- SleuthKit
- Hundreds of additional tools
