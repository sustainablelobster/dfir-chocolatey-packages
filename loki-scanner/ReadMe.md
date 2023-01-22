# Loki - Simple IOC and YARA Scanner

Scanner for Simple Indicators of Compromise

Detection is based on four detection methods:

    1. File Name IOC
       Regex match on full file path/name

    2. Yara Rule Check
       Yara signature match on file data and process memory

    3. Hash Check
       Compares known malicious hashes (MD5, SHA1, SHA256) with scanned files
       
    4. C2 Back Connect Check
       Compares process connection endpoints with C2 IOCs (new since version v.10)
       
Additional Checks:

    1. Regin filesystem check (via --reginfs)
    2. Process anomaly check (based on [Sysforensics](http://goo.gl/P99QZQ)
    3. SWF decompressed scan (new since version v0.8)
    4. SAM dump check

The Windows binary is compiled with PyInstaller and should run as x86 application on both x86 and x64 based systems.

## Note on VirusTotal detections

This software is packaged using [PyInstaller](https://pyinstaller.org/en/stable/),
a tool for bundling Python applications into a single executable. Apps packaged
in this manner are often incorrectly flagged as malware. PyInstaller's core
developer explains the issue here: https://github.com/pyinstaller/pyinstaller/issues/6754#issuecomment-1100821249