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

Find out the list of disks that are mapped to a given host:

Physical Appliance
```bash
lshostvdiskmap

id name            SCSI_id vdisk_id vdisk_name      vdisk_UID                        IO_group_id IO_group_name 
1  mars_dem0004306 1       25       vm-56E228035D00 638A95F2258000019000000000014C74 0           io_grp0       
1  mars_dem0004306 3       222      vm-597AEFB30D00 638A95F2258000019000000000027186 0           io_grp0       
1  mars_dem0004306 7       47       vm-56E7A6DA6100 638A95F2258000019000000000014EA6 0           io_grp0       
2  venus_de0004309 1       25       vm-56E228035D00 638A95F2258000019000000000014C74 0           io_grp0       
2  venus_de0004309 3       222      vm-597AEFB30D00 638A95F2258000019000000000027186 0           io_grp0       
2  venus_de0004309 7       47       vm-56E7A6DA6100 638A95F2258000019000000000014EA6 0           io_grp0       
3  av_aix0710683   0       9        AIXVDISK0       638A95F225800001900000000002E3B2 0           io_grp0       
3  av_aix0710683   1       12       AIXVDISK1       638A95F225800001900000000002E3B3 0           io_grp0       
3  av_aix0710683   2       33       AIXVDISK2       638A95F225800001900000000002E3B4 0           io_grp0       
3  av_aix0710683   3       34       AIXVDISK3       638A95F225800001900000000002E3B5 0           io_grp0       
8  grid_tra3440046 1       122      vm-5726CB1C4700 638A95F2258000019000000000016732 0           io_grp0       
8  grid_tra3440046 2       131      rs-57572E603300 638A95F2258000019000000000018221 0           io_grp0       
9  rh-ron5075996   0       8        ronsvdisk1      638A95F2258000019000000000023042 0           io_grp0       
9  rh-ron5075996   1       4        elevenGB        638A95F2258000019000000000023412 0           io_grp0       
9  rh-ron5075996   2       121      twelveGB        638A95F2258000019000000000023413 0           io_grp0       
9  rh-ron5075996   3       175      thirteenGB      638A95F2258000019000000000023414 0           io_grp0       
9  rh-ron5075996   4       176      fourteenGB      638A95F2258000019000000000023415 0           io_grp0       
9  rh-ron5075996   5       6        brylan100gb     638A95F2258000019000000000026D03 0           io_grp0       
9  rh-ron5075996   7       206      ba4GB1          638A95F2258000019000000000026D0C 0           io_grp0       
9  rh-ron5075996   8       207      ba4GB2          638A95F2258000019000000000026D0D 0           io_grp0       
10 sql5088900      0       95       ronsvdisk2      638A95F2258000019000000000023085 0           io_grp0       
10 sql5088900      2       214      vm-59717C810200 638A95F2258000019000000000026D41 0           io_grp0  
```

Virtual Appliance
```bash
. /act/servicetools/queries
exportedvolumedata

/act/postgresql/bin/psql actdb act -c "select a.id,b.hostname,b.svcname,a.vdiskname,a.vdisknumber,a.uuid,a.portname,a.devicetag,a.hbaid,a.lun from exportedvolumedata a, hostdata b where a.hostname=b.svcname order by id"
   id   |   hostname    |     svcname     |    vdiskname    | vdisknumber |               uuid               | portname |   devicetag   | hbaid | lun 
--------+---------------+-----------------+-----------------+-------------+----------------------------------+----------+---------------+-------+-----
  14234 | SQ101         | sq1010014016    | vm-5A4D7D2A0700 |       65541 | 638A95F0000000054577CFC000010005 |          | i-160beb1d224 |     0 |   1
 258672 | SQ101         | sq1010014016    | vm-5A5D767D5000 |       65613 | 638A95F0000000054577CFC00001004D |          | i-160fd17dcc1 |     0 |   4
 283885 | centosa.mdemo | centosa_0014049 | rs-5A8A59042200 |       65795 | 638A95F0000000054577CFC000010103 |          | i-161ac6c3533 |     0 |   5
 287618 | SQ101         | sq1010014016    | vm-5A8BD81C4400 |       65829 | 638A95F0000000054577CFC000010125 |          | i-161b244a80b |     0 |   3
 302393 | SQ101         | sq1010014016    | rs-5A8E120B1F00 |       65873 | 638A95F0000000054577CFC000010151 |          | i-161baf9fd84 |     0 |   2
 306531 | centosa.mdemo | centosa_0014049 | vm-5A9266024900 |       65907 | 638A95F0000000054577CFC000010173 |          | i-161cbdec31b |     0 |   2
 306619 | centosa.mdemo | centosa_0014049 | vm-5A9268273200 |       65911 | 638A95F0000000054577CFC000010177 |          | i-161cbe71a6c |     0 |   1
 315361 | SQ101         | sq1010014016    | vm-5A98A4B22600 |       66001 | 638A95F0000000054577CFC0000101D1 |          | i-161e4442388 |     0 |   7
 529969 | SQ101         | sq1010014016    | rs-5AC044822F00 |       66459 | 638A95F0000000054577CFC00001039B |          | i-1627f0cc518 |     0 |   5
 530060 | SQ101         | sq1010014016    | rs-5AC0702E6200 |       66461 | 638A95F0000000054577CFC00001039D |          | i-1627fb9ed34 |     0 |   6
(10 rows)

/act/postgresql/bin/psql actdb act -c "select a.id,b.hostname,b.svcname,a.vdiskname,a.vdisknumber,a.uuid,a.portname,a.devicetag,a.hbaid,a.lun from exportedvolumedata a, hostdata b where a.hostname=b.svcname order by id"
  id  |  hostname  |     svcname     |    vdiskname    | vdisknumber |               uuid               | portname |   devicetag   | hbaid | lun 
------+------------+-----------------+-----------------+-------------+----------------------------------+----------+---------------+-------+-----
 6197 | melnaborcl | melnabor0005205 | rs-5ACBF2F41400 |       65557 | 638A95F0000000054585C34000010015 |          | i-162acad80bd |     0 |   1
 7111 | melnaborcl | melnabor0005205 | vm-5ACB40B75C00 |       65547 | 638A95F0000000054585C3400001000B |          | i-162acbbb2e4 |     0 |   2
(2 rows)

# cat /sys/kernel/scst_tgt/devices/i-162acad80bd/prod_id
ActifioSky
[key]

# ls -la /sys/kernel/scst_tgt/devices/
total 0
drwxr-xr-x 10 root root 0 Apr 10 09:26 .
drwxr-xr-x  7 root root 0 Apr  9 12:10 ..
drwxr-xr-x  3 root root 0 Apr  9 22:11 2:0:0:0
drwxr-xr-x  3 root root 0 Apr  9 22:11 2:0:1:0
drwxr-xr-x  3 root root 0 Apr  9 22:11 2:0:2:0
drwxr-xr-x  3 root root 0 Apr  9 22:11 2:0:3:0
drwxr-xr-x  3 root root 0 Apr  9 22:11 4:0:0:0
drwxr-xr-x  3 root root 0 Apr  9 12:10 disk00
drwxr-xr-x  3 root root 0 Apr 10 09:11 i-162acad80bd
drwxr-xr-x  3 root root 0 Apr 10 09:26 i-162acbbb2e4

melnabsky:/dumps # zfs list | grep vm-5ACB40B75C00
act_per_pool000/vm-5ACB40B75C00   541M   487G   500M  -
melnabsky:/dumps # zfs list | grep rs-5ACBF2F41400
act_per_pool000/rs-5ACBF2F41400   335M   487G   807M  -

```

To show CDS iSCSI ports instead of Fibre Channel ports:
```
reportfabric -i

FabricType  VendorType   HostName                   MappedHostName   MappedHostType  HostStatus  HostIQN                                                Node1Port1:172.24.16.41
Host        Linux        grid.train.actifio.com     grid_tra3440046  generic         offline     iqn.1994-05.com.redhat:db8bf987928a                    -
Host        Linux        rhelorcl.net               rhelorcl3260951  generic         offline     iqn.1994-05.com.redhat:6789b6644218                    -
Host        UnknownType  NotDefined                 aaa0501637       generic         offline     aaa                                                    -
Host        generic      AV AIX                     av_aix0710683    generic         offline     iqn.localhost.atmlpar20                                -
Host        generic      SQL                        sql5088900       generic         offline     iqn.1991-05.com.microsoft:vq-sql                       -
Host        generic      pyoracle                   pyoracle5752234  generic         offline     iqn.1994-05.com.redhat:93415dc71dfe                    -
Host        generic      rh-ron                     rh-ron5075996    generic         offline     iqn.1994-05.com.redhat:c44b68fb919a                    -
Host        vcenter      vcenter.train.actifio.com  vq-vcent0004301  generic         offline     iqn.1991-05.com.microsoft:vcenter.train.actifio.com    -
Host        vcenter      vcenter.train.actifio.com  vq-vcent0004301  generic         offline     iqn.1991-05.com.microsoft:vq-vcenter.demo.actifio.com  -


HostName       HostID  HostType  HostIQN                             HostIPs                      eth0:172.24.16.192
centosa.mdemo  14049   Linux     iqn.1988-12.com.oracle:b99a8d67654  172.24.16.190 172.24.50.190  172.24.16.190
SQ101          14016   Win32     iqn.1991-05.com.microsoft:sq101     172.24.16.191                172.24.16.191

HostName    HostID  HostType  HostIQN                             HostIPs      eth0:10.65.5.193
melnaborcl  5205    Linux     iqn.1988-12.com.oracle:a2677fd2e7a  10.65.5.190  10.65.5.190
```

### Linux host
```
[root@melnaborcl ~]# ls -l /dev/disk/by-id | grep -i scsi
lrwxrwxrwx 1 root root  9 Apr  9 19:26 scsi-3638a95f0000000054585c3400001000b -> ../../sdf
lrwxrwxrwx 1 root root  9 Apr  9 19:11 scsi-3638a95f0000000054585c34000010015 -> ../../sde
lrwxrwxrwx 1 root root  9 Apr  9 19:11 scsi-3ffffffffffff -> ../../sdd

[root@melnaborcl ~]# ls -l /dev/disk/by-path
total 0
lrwxrwxrwx 1 root root  9 Apr  9 19:11 ip-10.65.5.193:3260-iscsi-iqn.2009-04.com.actifio:1194874dfd0-lun-0 -> ../../sdd
lrwxrwxrwx 1 root root  9 Apr  9 19:11 ip-10.65.5.193:3260-iscsi-iqn.2009-04.com.actifio:1194874dfd0-lun-1 -> ../../sde
lrwxrwxrwx 1 root root  9 Apr  9 19:26 ip-10.65.5.193:3260-iscsi-iqn.2009-04.com.actifio:1194874dfd0-lun-2 -> ../../sdf

[root@melnaborcl ~]# ls -l /dev/disk/by-label
total 0
lrwxrwxrwx 1 root root 10 Apr  8 22:02 DATA1 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Apr  8 22:02 DATA2 -> ../../sdc1

[root@melnaborcl ~]# ls -l /dev/disk/by-uuid/
total 0
lrwxrwxrwx 1 root root 10 Apr  8 22:02 2a3c48ba-70fa-4e32-a611-fca3e7462ae2 -> ../../dm-0
lrwxrwxrwx 1 root root 10 Apr  8 22:02 4aa2a720-3e99-472f-a81a-dc46d3a65e63 -> ../../sda1
lrwxrwxrwx 1 root root 10 Apr  8 22:02 e949b30a-d7c0-48be-b047-065930a3f699 -> ../../dm-1

[root@melnaborcl ~]# ls -la /dev/actifio/asm
total 0
drwxrwxrwx 2 root   root        80 Apr  9 19:26 .
drwxrwxrwx 3 root   root        60 Apr  9 00:22 ..
brw-rw---- 1 oracle oinstall 8, 80 Apr 10 00:55 scsi-638A95F0000000054585C3400001000B
brw-rw---- 1 oracle oinstall 8, 64 Apr 10 00:55 scsi-638A95F0000000054585C34000010015

# Login as root:
# fdisk -l | grep "Disk /dev"
Disk /dev/sda: 53.7 GB, 53687091200 bytes
Disk /dev/sdb: 10.7 GB, 10737418240 bytes
Disk /dev/sdc: 10.7 GB, 10737418240 bytes
Disk /dev/mapper/vg_melnaborcl-lv_root: 38.4 GB, 38444990464 bytes
Disk /dev/mapper/vg_melnaborcl-lv_swap: 14.7 GB, 14713618432 bytes
Disk /dev/sdd: 0 MB, 65536 bytes
Disk /dev/sde: 53.7 GB, 53687091200 bytes
Disk /dev/sdf: 53.7 GB, 53687091200 bytes


[root@melnaborcl ~]# scsi_id -gud /dev/sde
3638a95f0000000054585c34000010015
[root@melnaborcl ~]# scsi_id -gud /dev/sdf
3638a95f0000000054585c3400001000b

su - oracle
export ORACLE_SID=+ASM ; ORAENV_ASK=NO ; . oraenv ; unset ORAENV_ASK 
$ kfed read /dev/actifio/asm/scsi-638A95F0000000054585C3400001000B | grep -i name
kfdhdb.dskname:            ACTDEMO_0000 ; 0x028: length=12
kfdhdb.grpname:                 ACTDEMO ; 0x048: length=7
kfdhdb.fgname:             ACTDEMO_0000 ; 0x068: length=12
kfdhdb.capname:                         ; 0x088: length=0

[oracle@orcl ~]$ asmcmd lsdg
State    Type    Rebal  Sector  Block       AU  Total_MB  Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  EXTERN  N         512   4096  1048576     51200    49385                0           49385              0             N  ACTDEMO/
MOUNTED  EXTERN  N         512   4096  1048576     20478    17832                0           17832              0             N  DATA/
MOUNTED  EXTERN  N         512   4096  1048576     51200    39770                0           39770              0             N  VDEMO_ACDG/

[oracle@orcl ~]$ asmcmd lsdsk
Path
/dev/actifio/asm/scsi-638A95F0000000054585C3400001000B
/dev/actifio/asm/scsi-638A95F0000000054585C34000010023
ORCL:DATA1
ORCL:DATA2

```


