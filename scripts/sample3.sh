#!/bin/bash
#
# File: /home/oracle/s3.sh
#
set +x

export ORACLE_SID=$1 ; ORAENV_ASK=NO ; . oraenv >/dev/null ; unset ORAENV_ASK

v_tscount=$(sqlplus -s "/ as sysdba" << EOS
    set pages 0 feed off verify off head off echo off;
    select count(tablespace_name) from dba_tablespaces;
    exit;
EOS
)
printf "Number of tablespaces : %s\n" $v_tscount

#
#  su - oracle -c '/home/oracle/sample3.sh audemo'
#
