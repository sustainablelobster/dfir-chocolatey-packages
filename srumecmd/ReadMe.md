# SrumECmd Introduction

SrumECmd is a tool created by Eric Zimmerman used to parse the SRUM database. The SRUM database is located at C:\Windows\System32\sru\SRUDB.dat and serves as the backend for Windows Task Manager.

## SrumECmd Use Cases

### Law Enforcement

For those in Law Enforcement, this tool is useful for parsing the SRUM database which can provide another source of program execution for media players, photo viewers, etc. Additionally, being able to see Bytes Read and Bytes Written by various programs may help provide insight as to the size of files certain applications were handling. This may be important relating to crimes involving contraband multimedia files. Additionally, for P2P cases, Bytes Sent and Bytes Received artifacts can prove to be crucial datapoints for the purpose of the investigation.

### Private Sector

For those in the Private Sector, this tool is useful for parsing the SRUM database which can provide another source of program execution for potentially malicious executables. Additionally, Bytes Sent and Bytes Received can sometimes be the only indicator of data exfiltration in the instance of a ransomware case. If a case is known to involve data exfiltration, the SRUM database should be a mandatory artifact to parse and analyze so long as the suspected data exfiltration occurred within the 30 days of when the SRUM database was parsed.