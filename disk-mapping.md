## Introduction

List the mounted images on the host (tgthost)
```bash
reportmountedimages | grep -i tgthost
```
```powershell
reportmountedimages | where { $_.MountedHost -eq "tgthost" }
```

Find out the internal hostname for tgthost
```bash
udsinfo lshost
```
```powershell
udsinfo lshost | where { $_.hostname -eq "tgthost" } | select svcname
```

Find out the disks that are mapped to the host:

Physical Appliance
```bash
lshostvdiskmap
```

Virtual Appliance
```bash

```
