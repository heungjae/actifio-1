#!/bin/bash

## File: lc-phase2-pre.sh
#
set +x

LOG_FILE=/act/scripts/trace.log

echo "** `date \"+%Y.%m.%d-%H.%M.%S\"` Executing script ( $0 ) **" >> $LOG_FILE

if [[ -z "$ACT_MULTI_END" ]] && [[ $ACT_MULTI_END != "true" ]]; then
   echo "NO-OP for multi-phase operation"
   exit 0
fi

if [[ $ACT_PHASE == "pre" && $ACT_MULTI_END == "true" ]]; then
    if [[ $ACT_JOBTYPE == "reprovision" && $ACT_MULTI_OPNAME == "unmount" ]] ; then
       echo "Save existing data before reprovisioning the MASKED Oracle database !" >> $LOG_FILE
       ps -ef | grep pmon >> $LOG_FILE
       echo "--------------------------------------------------------------" >> $LOG_FILE
       exit 0
    elif [[ $ACT_JOBTYPE == "mount" && $ACT_MULTI_OPNAME == "mount" ]] ; then
       echo "Nothing to save from MASKED database as this is a new provision !" >> $LOG_FILE
       echo "--------------------------------------------------------------" >> $LOG_FILE
       exit 0
    fi
fi
