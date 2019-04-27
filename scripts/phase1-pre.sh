#!/bin/bash

## File: lc-phase1-pre.sh
#
set +x

ORACLE_SID=M02

LOG_FILE=/act/scripts/trace.log
db_running=`ps -ef | grep ora_pmon_${ORACLE_SID} | grep -v grep | wc -l`

echo "** `date \"+%Y.%m.%d-%H.%M.%S\"` Executing script ( $0 ) **" >> $LOG_FILE

# set | grep -i act_ >> $LOG_FILE

if [[ -z "$ACT_MULTI_END" ]] && [[ $ACT_MULTI_END != "true" ]]; then
   echo "NO-OP for multi-phase operation"
   exit 0
fi

if [[ $ACT_PHASE == "pre" && $ACT_JOBTYPE == "scrub-mount" && $ACT_MULTI_END == "true" ]]; then
    if [[ $ACT_MULTI_OPNAME == "scrub-mount" || $ACT_MULTI_OPNAME == "mount" ]] ; then
      if [[ $db_running == "1" ]]; then
         echo "Save existing data before reprovisioning the MASKED database !" >> $LOG_FILE
         ps -ef | grep pmon >> $LOG_FILE
         echo "--------------------------------------------------------------" >> $LOG_FILE
      else
         echo "Nothing to save from MASKED database as this is a new provision !" >> $LOG_FILE
         echo "--------------------------------------------------------------" >> $LOG_FILE
      fi
      exit 0
    fi
fi
