### Overview ###


#### Rescan SCSI bus to add a SCSI device on Linux without rebooting ###
List all the existing host bus number on your system with the folowing command:
```
# ls /sys/class/scsi_host
host0 host1
```

And, then rescan the SCSI bus to add a new SCSI device:
```
# echo "- - -" > /sys/class/scsi_host/host0/scan
# echo "- - -" > /sys/class/scsi_host/host1/scan
# fdisk -l
# tail -f /var/log/message
```

If you have lots of hosts, use the following:
```
for host in `ls /sys/class/scsi_host/` ; do
echo "- - -" >/sys/class/scsi_host/${host}/scan;
done
```

The triple dashes, - - -, are wildcards that rescan every channel, every target, and every LUN on the specificed SCSI host.

```
# fdisk -l 2>/dev/null | egrep '^Disk' | egrep -v 'dm-|type|identifier'
Disk /dev/sda: 53.7 GB, 53687091200 bytes
Disk /dev/sdb: 10.7 GB, 10737418240 bytes
Disk /dev/sdc: 10.7 GB, 10737418240 bytes
Disk /dev/mapper/vg_melnaborcl-lv_root: 38.4 GB, 38444990464 bytes
Disk /dev/mapper/vg_melnaborcl-lv_swap: 14.7 GB, 14713618432 bytes

# fdisk -l | grep sd
Disk /dev/sda: 53.7 GB, 53687091200 bytes
/dev/sda1   *           2         501      512000   83  Linux
/dev/sda2             502       51200    51915776   8e  Linux LVM
Disk /dev/sdb: 10.7 GB, 10737418240 bytes
/dev/sdb1               1       10240    10485744   83  Linux
Disk /dev/sdc: 10.7 GB, 10737418240 bytes
/dev/sdc1 
```
