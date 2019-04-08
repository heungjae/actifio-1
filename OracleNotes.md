## Introduction

### Checklist
The following is a checklist of all the required settings and components in an Oracle database prior to capturing it using Actifio software.

```

[ ] Actifio Application Aware mounts may fail if your Oracle 12c installation does not include this patch. Oracle Database 12c Bug# 19404068 (ORA-1610 ON RECOVER DATABASE FOR CREATED CONTROLFILE)
• (Patch 19404068) Linux x86-64 for Oracle 12.1.0.2.0
• (Patch 19404068) IBM AIX on POWER Systems (64-bit) for Oracle 12.1.0.2.0
• (Patch 19404068) Solaris on SPARC (64-bit) for Oracle 12.1.0.2.0
To see if the patch is installed, run:
  $ cd $ORACLE_HOME/OPatch
  $ ./opatch lsinventory -details
   
The following files need to contain the relevant enteries for the database that you wish to protect using Actifio
•	oratab file : typically contains an entry for each database, used by the oraenv software.
•	tnsnames.ora file : configuration file containing the net service names, used to connect to an Oracle database
•	listener.ora file : configuration file for a listener. Listener receives the incoming client connection requests and direct them to the database server.

[ ] Login as oracle, and set ORACLE_HOME and database environment variables manually, 
      export ORACLE_HOME=<oracle home path>
      export ORACLE_SID=<database instance name>
      export ORACLE_SID=orcl 
      export ORACLE_BASE=/u01/app/oracle
      export ORACLE_HOME=/u01/app/oracle/product/11.2.0/db_1
      export TNS_ADMIN=$ORACLE_HOME/network/admin      
      export PATH=$ORACLE_HOME/bin:$PATH"    
    or switch to the database to be protected by running 
    -->  . oraenv
      
[ ] Verify database is running in ARCHIVE LOG mode. You should be able to check the archive mode in the Database log mode.
      sql> archive log list
[ ] Enable archivelog if it's not running. Test button will fail (NOARCHIVELOG mode is not supported)
      SQL> archive log list;
      SQL> startup mount
      alter system set db_recovery_file_dest_size=10G scope=both
      alter system set db_recovery_file_dest='+data'
      SQL> alter database archivelog;
      SQL> alter database open;
[ ] Verify database is running with spfile. Look out for the VALUE column for spfile.
      sql> show parameter spfile
      sql> # create spfile from pfile;
[ ] Recommend enabling database change block tracking. With database CBT off incremental backup time will be impacted. Oracle 
    database block change tracking feature is available in oracle Enterprise Edition. SQL query to check block change tracking
    enabled/disabled: Run the query from sqlplus connected as sysdba:
       sql> select * from v$block_change_tracking;"
    
    If tracking is not enabled, then enable database tracking from sqlplus:
   
    Using ASM Disk Group
    sql> alter database enable block change tracking using file '<ASM Disk Group Name>/<database name>/<dbname>.bct';
    
    Using File System
    sql> alter database enable block change tracking using file '$ORACLE_HOME/dbs/<dbname>.bct';    
      
[ ] Ensure the Oracle database to be protected is up and running	
    -->  ps -ef | grep pmon
[ ] Oracle database SID entry must be in /etc/oratab file . For a database named "oasm",the entry looks like:
      oasm:/home/oracle/app/oracle/product/11.1.0/db_1:Y"
[ ] Ensure the listener must be up and running	-->  ps -ef | grep tns
[ ] Bring up the listener if it's down	
    -->  su - oracle ; . oraenv ; lsnrctl status ; lsnrctl start ; lsnrctl reload ; lsnrctl services
[ ] If you are using Actifio ASM out-of-band protection, ensure ASM disk strings parameter is not null. Login as ASM OS user (connect to the +ASM instance), and run  
    -->  show parameter asm_diskstring




Create a database user account for Actifio backup (if not provided):
sql> create user act_rman_user identified by <password>;
e.g. SQL> create user act_rman_user identified by act_rman_user default tablespace users;

Grant sysdba access. For Oracle 12c this role can be sysbackup instead of sysdba. For RAC, the grant must be run on all nodes.
sql> grant create session, resource, sysdba to act_rman_user;

Verify the sysdba role has been granted. For RAC, verify the grant on all nodes.
sql> select * from v$pwfile_users;
To test the service name, login as Oracle user and set the Oracle environment
export TNS_ADMIN=$GRID_HOME/network/admin 
tnsping <service_name>"
Test the service name and user credentials. 

For Oracle 12c this role can be sysbackup instead of sysdba:	
sqlplus act_rman_user/act_rman_user@<service_name> as sysdba

Creating a Servicename Entry in tnsnames.ora	
Create the service name entry in the tnsnames.ora file at $ORACLE_HOME/network/admin or at $GRID_HOME/network/admin by adding the entry: 
<service_name> = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = <IP of the database server>)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = <service_name>)) )"


```


```
Queries on DBA_FREE_SPACE are Slow (Doc ID 271169.1) - http://m.blog.itpub.net/17252115/viewspace-1165254/
2) Large number of entries in sys.recyclebin$ can slow down the select on dba_free_space.
3) This is a normal behavior.

Solution
Purge the recyclebin.
For example:
SQL> purge recyclebin;
Recyclebin purged.
Or, as SYSDBA for system wide purging.
SQL> purge dba_recyclebin;
Recyclebin purged.
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
