#!/bin/bash

## File: dm-pre.sh
#
set +x

LOG_FILE=/act/scripts/trace.log

echo "** `date \"+%Y.%m.%d-%H.%M.%S\"` Executing script ( $0 ) **" >> $LOG_FILE

if [[ -z "$ACT_MULTI_END" ]] && [[ $ACT_MULTI_END != "true" ]]; then
   echo "NO-OP for multi-phase operation"
   exit 0
fi

if [[ $ACT_PHASE == "pre" && $ACT_JOBTYPE == "reprovision" && $ACT_MULTI_OPNAME == "unmount" && $ACT_MULTI_END == "true" ]]; then
    echo "Save existing data before reprovisioning the Oracle database !" >> $LOG_FILE
    echo "--------------------------------------------------------------" >> $LOG_FILE
    ps -ef | grep pmon >> $LOG_FILE
    exit
fi
