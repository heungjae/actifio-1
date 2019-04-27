#!/bin/bash

## File: lc-phase1-post.sh
#
set +x

LOG_FILE=/act/scripts/trace.log

echo "** `date \"+%Y.%m.%d-%H.%M.%S\"` Executing script ( $0 ) **" >> $LOG_FILE

if [[ -z "$ACT_MULTI_END" ]] && [[ $ACT_MULTI_END != "true" ]]; then
   echo "NO-OP for multi-phase operation"
   exit 0
fi

if [[ $ACT_PHASE == "post" && $ACT_MULTI_OPNAME == "scrub-mount" && $ACT_MULTI_END == "true" ]]; then
    if [[ $ACT_JOBTYPE == "reprovision" || $ACT_JOBTYPE == "scrub-mount" ]] ; then
       echo "Database is up and running ... restore data into the UNMASKED database !" >> $LOG_FILE
       ps -ef | grep pmon >> $LOG_FILE
       echo "--------------------------------------------------------------" >> $LOG_FILE
       exit 0
    fi
fi
