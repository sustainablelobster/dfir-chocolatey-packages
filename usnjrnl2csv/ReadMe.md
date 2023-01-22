

## Introduction

The journal is a log of changes to files on an NTFS volume. Such changes can for instance be the creation, deletion or modification of files or directories. It is optional to have it on, and can be configured with fsutil.exe on Windows. However, it was not turned on by default until Vista and later.

## Details

The journal, if turned on, can be found in the directory \$Extend and is named $UsnJrnl (this is not visible in explorer as it is part of the system files on NTFS). Actually it is an alternate data stream $J that contains the relevant data. This stream is usually rather large and can be several GB in size. Thus it may take quite some time to process, if filled up. The file is sparse, so preferrably use the ExtractUsnJrnl tool to extract it.

The structure is well known and very simple; http://www.microsoft.com/msj/0999/journal/journal.aspx 

The tool supports USN_RECORD_V2 and USN_RECORD_V3, but not USN_RECORD_V4 (introduced in Windows 8.1 and not activated by default.).

The nice thing about it, is that it contains large amount of historical data.

From version 1.0.0.5, all structure members were included in the output.

The USN_PAGE_SIZE is configurable. The default value is 4096, and should be sufficient for most cases.

Timestamps are written UTC 0.00 by default, but can be configured to anything. The format and precision of the timestamps can also be configured, as well as the millisec/precision separator. See displayed examples in the gui.

## Note on VirusTotal detections

This application is a compiled [AutoIt](https://www.autoitscript.com/site/) script.
AutoIt scripts packaged in this way are often incorrectly flagged as malware.
This is issue is documented in the AutoIt Wiki here: https://www.autoitscript.com/wiki/AutoIt_and_Malware
