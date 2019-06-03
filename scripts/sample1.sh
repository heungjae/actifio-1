#!/bin/bash
#
set +x

cat > /tmp/x.sql <<EOT

set pages 0 feed off
connect / as sysdba
select status from v\$instance;
archive log list;
exit

EOT

su - oracle -c 'export ORACLE_SID=audemo;export ORAENV_ASK=NO;. /usr/local/bin/oraenv;sqlplus -s / as sysdba @/tmp/x.sql'
