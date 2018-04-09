## Introduction

List the mounted images on the host (tgthost)
```bash
reportmountedimages | grep -i tgthost
```
```powershell
reportmountedimages | where { $_.MountedHost -eq "tgthost" }
```
