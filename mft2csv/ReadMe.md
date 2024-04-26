

## Introduction

This tool is for parsing, decoding and logging information from the Master File Table ($MFT) to a csv. It is logging a large amount of data and that has been the main purpose from the very start. Having all this data in a csv is convenient for further analysis. It supports getting the $MFT from a variety of sources.

## Details

Input can be any of the following:

    Raw/dd image of disk (MBR and GPT supported)
    Raw/dd image of partition
    $MFT extracted file
    Reading of $MFT directly from a live system
    Reading of $MFT by accessing \.\PhysicalDriveN directly (no mount point needed).
    Reading of $MFT directly from within shadow copies.
    $MFT fragments extracted from memory dumps or unallocated (see MFTCarver).
    Single records extracted. See MftRcrd with the -w switch.

There is an option to choose which UTC region to decode for. For instance you have a disk image and the target system had a timezone configuration of UTC -9.30, then you can configure it like that and get the timestamps directly into UTC 0.00. Default is UTC 0.00, and if running on a live system, there is no need to do anything as timestamps are automatically set to UTC 0.00.

The format of output can be chosen. Currently it is possible to choose from:

    All (will write to csv everything it can). Default set.
    log2timeline: http://code.google.com/p/log2timeline/wiki/l2t_csv
    bodyfile (v3.x): http://wiki.sleuthkit.org/index.php?title=Body_file

It is possible to parse broken/partial $MFT by configuring "Broken $MFT". This setting is necessary if for instance index number 0 is missing (the record for $MFT itself).

Also it is possible to configure the tool to skip fixups. This is something you may want if you are working on memory dumps. If so, you need to run MFTCarver on the memdump first. Then run mft2csv on the output file from MFTCarver. Must have both "Broken $MFT" and "Skip Fixups" configured in such a case.

## Note on VirusTotal detections

This application is a compiled [AutoIt](https://www.autoitscript.com/site/) script.
AutoIt scripts packaged in this way are often incorrectly flagged as malware.
This is issue is documented in the AutoIt Wiki here: https://www.autoitscript.com/wiki/AutoIt_and_Malware
