#!/bin/bash
#
# File: /home/oracle/s2.sh
#
set +x

## Function retrieve the value in v$parameter table based on the argument passed to it
#
populate_from_v_parameter () {
   rc=$(sqlplus -s "/ as sysdba" << EOT
   set pages 0 feed off verify off head off echo off;
   select value from v\$parameter where name='$1';
   exit;
EOT
)
   echo $rc
}

export ORACLE_SID=audemo ; ORAENV_ASK=NO ; . oraenv >/dev/null ; unset ORAENV_ASK
v_processes=$( populate_from_v_parameter "processes" )
echo "Number of processes: $v_processes"


#
#  su - oracle -c '/home/oracle/s2.sh' 
#
