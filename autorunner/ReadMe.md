# autorunner

autorunner is based upon the AutoRuns tool by the Sysinternals/Microsoft gurus. It is designed to perform automated [Authenticode](http://msdn.microsoft.com/en-gb/library/ms537359(v=vs.85).aspx) checking for binaries designed to auto-start on a host. Its primary purpose is to aid forensic investigations.

Autorunner will check against all user profiles associated with the host. It will parse out LNK files to the actual binary (one level down). It allows the user to specify multiple drive mappings, so that if the forensic image contains multiple partitions you can map the original drives to mounted drives on the forensic workstation.

The application should be used against a forensic image that has been mounted using whatever method you desire. 

## Notes

- Ensure that the image is mounted writeable, so that the writes are cached and the original image is not affected. This is so the application can take ownership of the files where necessary to ensure that everything is accessible to retrieve the file attributes**
- Make sure you run the application with elevated privileges e.g. Run As Administrator**

## Features ##

- Processes every user profile's path in one go
- Checks the authenticode signature via the Windows security catalog
- Parses LNK files
- Normalizes binary path
