## Introduction

### Checklist


Find out the configuration on the server:
```
cat /proc/meminfo | grep MemTotal
cat /proc/meminfo | grep SwapTotal
df –h
cat /etc/redhat-release
uname -a
Linux melnaborcl 2.6.32-696.23.1.el6.x86_64 #1 SMP Tue Mar 13 22:44:18 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
```
 

#### Each Oracle Database to be Protected Must be Running

##### Set the Oracle Database SID Entry
The database SID entry must be set in the /etc/oratab file (/var/opt/oracle/oratab on Solaris). For a database named “oasm” the entry looks like: `oasm:/home/oracle/app/oracle/product/11.1.0/db_1:Y`

[ ] The Oracle listener is up and running: `ps –ef | grep tns`. Alternatively login to Oracle OS user, set up the Oracle environment and run: Lsnrctl status

##### The Database Must Be Running in Archive Log Mode


##### The ASM diskstring Parameter Must Be Set
If you are using Oracle ASM protection out-of-band, then check that the ASM diskstring parameter is not null. Log into the database server as ASM OS user and set the ASM environment variable:

Following is the checklist:
[ ] If you are using Actifio ASM out-of-band protection, ensure ASM disk strings parameter is not null	
[ ] Connect to the +ASM instance, and login as ASM user (sqlplus / as sysasm). From the connected session, run `show parameter asm_diskstring`

```
set lines 120
col name for a30
col path for a30
col state for a30
select name,path from v$asm_disk;
select group_number,name,state,type from v$asm_diskgroup;
alter system set asm_diskstring='ORCL:*' ;

col compatibility format a10
col database_compatibility format a10
col name format a15
set linesize 200
col total_gb format 99099.99
col free_gb format 99099.99
select group_number, name, type, total_mb, total_mb/1024 total_gb, free_mb, free_mb/1024 free_gb, compatibility, database_compatibility from v$asm_diskgroup;

. oraenv
+ASM
sqlplus / as sysasm
shutdown immediate
alter system set asm_diskstring=NULL scope=spfile;
alter system set asm_diskstring='ORCL:*','/dev/actifio/asm/*' scope=spfile;
alter system set asm_diskstring='ORCL:*','/dev/actifio/asm/*' scope=both;
startup
```

Following is the checklist:
[ ] Switch to the database to be protected	; `. oraenv`
[ ] Set the database environment variables	
```
      export ORACLE_HOME=<oracle home path>
      export ORACLE_SID=<database instance name>
      export ORACLE_SID=orcl 
      export ORACLE_BASE=/u01/app/oracle
      export ORACLE_HOME=/u01/app/oracle/product/11.2.0/db_1
      export TNS_ADMIN=$ORACLE_HOME/network/admin      
      export PATH=$ORACLE_HOME/bin:$PATH"
```
[ ] Verify database is running with spfile. Look out for the VALUE column for spfile.
```
> sql> show parameter spfile  
> sql> # create spfile from pfile;  
```      
[ ] Verify database is running in archive mode. You should see Archive Mode in the Database log mode.
> sql> archive log list  
      
[ ] Enable archivelog if it's not running. Test button will fail (NOARCHIVELOG mode is not supported)
```
      SQL> archive log list;
      SQL> startup mount
      alter system set db_recovery_file_dest_size=10G scope=both
      alter system set db_recovery_file_dest='+data'
      SQL> alter database archivelog;
      SQL> alter database open;
```      
      
##### Oracle Database Authentication
Oracle database authentication uses your Oracle credentials. With Oracle Database Authentication, you must provide two kinds of Oracle credentials:
- Database credentials to connect to the database with sysdba privilege (sysbackup for Oracle 12c)
- An Oracle listener (tnsnames) service name to connect to the database as sysdba (sysbackup for Oracle 12c)

Create a database user account for Actifio backup (if not provided):
sql> create user act_rman_user identified by <password>;
e.g. SQL> create user act_rman_user identified by act_rman_user default tablespace users;

Grant sysdba access. For Oracle 12c this role can be sysbackup instead of sysdba. For RAC, the grant must be run on all nodes.
sql> grant create session, resource, sysdba to act_rman_user;

Create a database user account for Actifio backup (if not provided):
sql> create user act_rman_user identified by <password>;

3. Grant sysdba access:
sql> grant create session, resource, sysdba to act_rman_user;
For Oracle 12c this role can be sysbackup instead of sysdba, and the database user name starts with #.
 
4. Verify the sysdba role has been granted:
```
sqlplus / as sysasm
select * from gv$pwfile_users;
```

##### Creating and Verifying the Oracle Servicename in a non-RAC Environment
The Oracle Servicename is used for database authentication only.

Example: Database name: dbstd, Instance Name: dbstd
1. If the Oracle Servicename is not listed, then create the service name entry in the tnsnames.ora file at
```
$ORACLE_HOME/network/admin or at $GRID_HOME/network/admin by adding the entry:
act_svc_dbstd =
(DESCRIPTION =
(ADDRESS = (PROTOCOL = TCP)(HOST = <IP of the database server>)(PORT = 1521))
(CONNECT_DATA =
(SERVER = DEDICATED)
(SERVICE_NAME = dbstd)
) )
```

If the tnsnames.ora file is in a non-standard location, then provide the absolute path to it in the Application Advanced Settings described in Application Advanced Settings for Oracle Databases on page 26.

2. Test that the service name entry for the database is configured:
Login as Oracle OS user and set the Oracle environment:
```
TNS_ADMIN=<tnsnames.ora file location>
tnsping act_svc_dbstd
```

3. Check the database user account to be sure the Actifio backup can connect:
`sqlplus act_rman_user/act_rman_user@act_svc_dbstd as sysdba`

Verify the sysdba role has been granted. For RAC, verify the grant on all nodes.
sql> select * from v$pwfile_users;

To test the service name, login as Oracle user and set the Oracle environment
export TNS_ADMIN=$GRID_HOME/network/admin 
tnsping <service_name>"

Test the service name and user credentials. 

For Oracle 12c this role can be sysbackup instead of sysdba:	
sqlplus act_rman_user/act_rman_user@<service_name> as sysdba

##### Creating a Servicename Entry in tnsnames.ora	
Create the service name entry in the tnsnames.ora file at $ORACLE_HOME/network/admin or at $GRID_HOME/network/admin by adding the entry: 
<service_name> = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = <IP of the database server>)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = <service_name>)) )"


##### Oracle Database change block tracking (BCT):

[ ] Recommend enabling database change block tracking. With database CBT off incremental backup time will be impacted. Oracle database block change tracking feature is available in oracle Enterprise Edition. SQL query to check block change tracking enabled/disabled: Run the query from sqlplus connected as sysdba:
```
    sql> select * from v$block_change_tracking;
    
    set lines 120
    col status for a10
    col filename for a30
    col bytes for 999,999
     select status, filename,bytes from v$block_change_tracking;
```

Using ASM Disk Group
`alter database enable block change tracking using file '<ASM Disk Group Name>/<database name>/<dbname>.bct';`

Using File System
`alter database enable block change tracking using file '$ORACLE_HOME/dbs/<dbname>.bct';`

```
set lines 150
col name for a65
col member for a50
col bytes for 9,999,999,999
select status, enabled, bytes, name, checkpoint_change#  from v$datafile;
select name, status from v$controlfile;
select group#, status,type, member from v$logfile;

select host_name from v$instance;
select platform_name from v$database;
select file_name from dba_temp_files;

select distinct machine from v$session;
select name, value, unit from v$pgastat;
select name, value from v$sga;
select banner from v$version;

select instance_name, host_name, version, status, logins, database_status, instance_role, active_state from v$instance;

select name, created, sysdate, log_mode, controlfile_type, open_mode, protection_mode, database_role, db_unique_name, platform_name from v$database;

select recid, name, dest_id, sequence#, resetlogs_change#, status, next_change# from v$archived_log;

## Getting the last data update time of a specific table in Oracle
select max(ora_rowscn), scn_to_timestamp(max(ora_rowscn)) from scott.emp;

```

### Manual scripts
```
cd /act/act_scripts/oracleclone

OracleAppMount.sh (formerly customerClone.sh)
# sh ./customerClone.sh <New database sid name> <Oracle Home path> <Backup location mount path>

OracleAppMount_tstamp.sh (formerly customerClone_tstamp.sh)
# sh ./customerClone_tstamp.sh <New database sid name> <Oracle Home path> <Backup location mount path> <log mount path> <timestamp yyyymmddhh24mi>

OracleAppTeardown.sh (customerRewind.sh)
# sh ./customerRewind.sh testdb $ORACLE_HOME /act/mnt/Job_4537358_mountpoint_1417562372683/ 
```
