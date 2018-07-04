#### Introduction

```
udstask mountimage -image Image_3452221 -host grid.train.actifio.com -label T3MOUNT -restoreoption 'provisioningoptions=<provisioning-options><databasesid>TS3</databasesid><username>oracle</username><orahome>/u01/oracle/app/oracle/product/11.2.0/dbhome_1</orahome><tnsadmindir>/u01/oracle/app/oracle/product/11.2.0/dbhome_1/network/admin</tnsadmindir><rrecovery>false</rrecovery><standalone>true</standalone></provisioning-options>,asmracnodelist=172.24.50.134,volgroupname=T3DG'


udstask mountimage -image Image_3462736 -host grid.train.actifio.com -label T3MOUNT -restoreoption 'provisioningoptions=<provisioning-options><databasesid>TS3</databasesid><username>oracle</username><orahome>/u01/oracle/app/oracle/product/11.2.0/dbhome_1</orahome><tnsadmindir>/u01/oracle/app/oracle/product/11.2.0/dbhome_1/network/admin</tnsadmindir><rrecovery>false</rrecovery><standalone>true</standalone></provisioning-options>,asmracnodelist=172.24.50.134,volgroupname=T3DG'


./actDBM.pl --type cdsconfig --username michael.chew --password 12\!pass345 --CDS 172.24.50.42
perl actDBM.pl --type backup --dbname tulip --hostname grid.train.actifio.com --backuptype dblog --backuplabel perlbkup1 --CDS 172.24.50.42 --wait yes


set -x
udstask mountimage -image Image_3442313 -host grid.train.actifio.com -label T2MOUNT -restoreoption 'provisioningoptions=<provisioning-options><databasesid>T2</databasesid><username>oracle</username><orahome>/u01/oracle/app/oracle/product/11.2.0/dbhome_1</orahome><tnsadmindir>/u01/oracle/app/oracle/product/11.2.0/dbhome_1/network/admin</tnsadmindir><rrecovery>false</rrecovery><standalone>true</standalone></provisioning-options>,asmracnodelist=172.24.50.134,volgroupname=T2DG'
#udstask mountimage -image Image_3440237 -host grid.train.actifio.com -label T2MOUNT -restoreoption 'provisioningoptions=<provisioning-options><databasesid>T2</databasesid><username>oracle</username><orahome>/u01/oracle/app/oracle/product/11.2.0/dbhome_1</orahome><tnsadmindir>/u01/oracle/app/oracle/product/11.2.0/dbhome_1/network/admin</tnsadmindir><rrecovery>true</rrecovery><standalone>true</standalone></provisioning-options>,asmracnodelist=172.24.50.134,volgroupname=T2DG'
#udstask unmountimage -image Image_3440237 -delete -force

udstask mountimage -image Image_0148957 -host w2k8-sql -restoreoption 'mountpointperdiskddasvol:C:\=C:\Test\sqldb1,provisioningoptions=<provisioning-options><sqlinstance>WIN2K8-SQL\SQLSERVER</sqlinstance><dbname>sqldb1</dbname><recover>true</recover></provisioning-options>' -recoverytime ‘2016-01-26 3:15:00’

"udstask mountimage -image Image_3440237 -host grid.train.actifio.com -label T2MOUNT 
-restoreoption 'provisioningoptions=<provisioning-options><databasesid>T2</databasesid><username>oracle</username><orahome>/u01/oracle/app/oracle/product/11.2.0/dbhome_1</orahome><tnsadmindir>/u01/oracle/app/oracle/product/11.2.0/dbhome_1/network/admin</tnsadmindir><rrecovery>true</rrecovery><standalone>true</standalone></provisioning-options>,asmracnodelist=172.24.50.134,volgroupname=T2DG' 
-recoverytime 2016-05-01 23:56:00"

```
