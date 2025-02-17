# SBECmd Introduction

SBECmd is a tool created by Eric Zimmerman used to parse the NTUSER.dat and UsrClass.dat Registry hives. These hives contains shell items that are recorded by Windows which indicate which folders a user has traversed.

## SBECmd Use Cases

### Law Enforcement

For those in Law Enforcement, this tool is useful for parsing the NTUser.dat and UsrClass.dat user Registry hives which will contain artifacts of folder traversal. Since the NTUser.dat and UsrClass.dat Registry hives exist for each user, one can attribute the folder traversal artifacts to a specific account. For Law Enforcement, these artifacts may provide pointers to folders or ZIP files that no longer exist. This artifact will provide the first and last time the specific user interacted with a specific folder or ZIP file, in most cases.

### Private Sector

For those in the Private Sector, this tool is useful for enumerating what a user of interest did during unauthorized access to a given host. Often, artifacuts during periods of unauthorized access will show the threat actor accessing and viewing files and folders that are highly sensitive to the client’s business.
