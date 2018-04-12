## Switching from iSCSI to FC ##

This document lists the steps required:

### Preparation 
Collect information from both the **Oracle** host and **Actifio** appliance.

#### Actifio appliance
- [ ] `udsinfo lshost` to find out detail information on the Linux host (svcname)
- [ ] `reportmountedimages` to find out the images that are mounted to the host
- [ ] `lshostvdiskmap` to find out which Actifio LUN is mapped to the Linux host using the svcname
- [x] `reportfabric -i` to list all the iSCSI connections 

#### Linux Host
```
col path format a70
col name format a18
set linesize 100
select name, path from v$asm_disk order by 1;
asmcmd lsdg
asmcmd lsdsk
```
- [ ] `iscsiadm -m session` to list all the iSCSI sessions
- [ ] `iscsiadm -m node -u` to logoff all the sessions on the host
- [ ] `ls /var/lib/iscsi/nodes`
- [ ] `iscsiadm -m node -T iqn.2009-04.com.actifio:1194874dfd0 -p 10.65.5.193 -o delete`
- [ ] `service iscsid stop` to stop the iSCSI daemon process
- [ ] `service iscsi stop` to stop the iSCSI process
- [ ] `ls -l /dev/disk/by-id/` to list the devices mapped from Actifio
- [ ] `ls -l /dev/disk/by-id/ | grep -i scsi` to list the devices 
- [ ] `ls -l /dev/disk/by-label` to list the devices 
- [ ] `ls -l /dev/disk/by-path` to list the devices 
- [ ] `ls -l /dev/actifio/asm/` to list the devices
- [ ] `kfed read /dev/actifio/asm/scsi-638A95F0000000054585C3400001000B | grep -i name` to list the header of the Linux device
- [ ] `fdisk -l | grep "Disk /dev"` to list the header of the Linux device
- [ ] `scsi_id -gud /dev/sde` to list the header of the Linux device
- [ ] `tail -f /var/act/log/UDSAgent.log` to 
- [ ] `tail -f /var/act/log/<ORACLE_SID>_rman.log` to 
- [ ] `tail -f /act/act_scripts/asmclone/dbrecover_<ORACLE_SID>.txt`
- [ ] `tail -f /act/act_scripts/asmclone/openDBlog_<ORACLE_SID>.txt`
- [ ] `tail -f /act/act_scripts/asmclone/newsidlog.log`

