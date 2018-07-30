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

##### The ASM diskstring Parameter Must Be Set

      
[ ] Enable archivelog if it's not running. Test button will fail (NOARCHIVELOG mode is not supported)
```
      SQL> archive log list;
      SQL> startup mount
      alter system set db_recovery_file_dest_size=10G scope=both
      alter system set db_recovery_file_dest='+data'
      SQL> alter database archivelog;
      SQL> alter database open;
```      
      



Run the query from sqlplus connected as sysdba:
   
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
