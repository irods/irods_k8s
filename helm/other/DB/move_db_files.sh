#!/bin/bash

############################################################
# script to move the last db backup files from dev to prod
# Note this is designed to be run in the same directory as this file
# #########################################################

# prototype command line:
  # bash move_db_files.sh
    # <source namespace environment> <dest source namespace environment>
    # <source namespace> <dest namespace>
    # <source pod name> <dest pod name>

# example to copy files from eds-dev to AWS/EKS:
  # bash move_db_files.sh powen@sterling arn:aws:eks:us-east-2:732457422609:cluster/apsviz-efs eds-dev apsviz apsviz-supervisor-dev- apsviz-supervisor-

# example to copy files from eds-dev to eds (prod):
  # bash move_db_files.sh powen@sterling powen@sterling eds-dev eds apsviz-supervisor-dev- apsviz-supervisor-

# example to copy files from eds (prod) to eds-dev:
  # bash move_db_files.sh powen@sterling powen@sterling eds eds-dev apsviz-supervisor- apsviz-supervisor-dev-

# example to copy files from eds-dev to powen:
  # bash move_db_files.sh powen@sterling powen@sterling eds-dev powen apsviz-supervisor-dev-78685c8d8f-xv2gv eds-access-c77cbcc96-mfwkm


SRC_ENV=$1
DEST_ENV=$2
SRC_NAMESPACE=$3
DEST_NAMESPACE=$4
SRC_POD=$5
DEST_POD=$6

echo && echo "Copying the files in the $SRC_ENV/$SRC_NAMESPACE/$SRC_POD pod to the $DEST_ENV/$DEST_NAMESPACE/$DEST_POD pod." && echo
read -rsp $'Press enter to continue...\n'

# make sure we are connected to the source k8s environment
kubectl ctx $SRC_ENV

# get the dump files from dev
echo && echo "Getting the source backup files from $SRC_NAMESPACE/$SRC_POD" && echo
kubectl -n $SRC_NAMESPACE --retries 10 cp $SRC_POD:/data/db-backups/adcirc_obs.dump.1 ./backups/adcirc_obs.dump.1
kubectl -n $SRC_NAMESPACE --retries 10 cp $SRC_POD:/data/db-backups/asgs_dashboard.dump.1 ./backups/asgs_dashboard.dump.1
kubectl -n $SRC_NAMESPACE --retries 10 cp $SRC_POD:/data/db-backups/apsviz.dump.1 ./backups/apsviz.dump.1
kubectl -n $SRC_NAMESPACE --retries 10 cp $SRC_POD:/data/db-backups/apsviz_cog_mosaic.dump.1 ./backups/apsviz_cog_mosaic.dump.1
kubectl -n $SRC_NAMESPACE --retries 10 cp $SRC_POD:/data/db-backups/dbglobals.sql.1 ./backups/dbglobals.sql.1
kubectl -n $SRC_NAMESPACE --retries 10 cp $SRC_POD:/data/db-backups/apsviz_gauges.dump.1 ./backups/apsviz_gauges.dump.1
kubectl -n $SRC_NAMESPACE --retries 10 cp $SRC_POD:/data/db-backups/ts_dbglobals.sql.1 ./backups/ts_dbglobals.sql.1

# make sure we are connected to the target k8s cluster
kubectl ctx $DEST_ENV

# remove .1.sav dump files
echo && echo "Removing the .sav backup files on the destination $DEST_NAMESPACE/$DEST_POD" && echo
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- rm /data/db-backups/adcirc_obs.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- rm /data/db-backups/asgs_dashboard.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- rm /data/db-backups/apsviz.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- rm /data/db-backups/apsviz_cog_mosaic.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- rm /data/db-backups/dbglobals.sql.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- rm /data/db-backups/apsviz_gauges.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- rm /data/db-backups/ts_dbglobals.sql.1.sav

# rename the target dump files
echo && echo "Renaming the destination backup files to .sav on the destination $DEST_NAMESPACE/$DEST_POD" && echo
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- mv /data/db-backups/adcirc_obs.dump.1 /data/db-backups/adcirc_obs.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- mv /data/db-backups/asgs_dashboard.dump.1 /data/db-backups/asgs_dashboard.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- mv /data/db-backups/apsviz.dump.1 /data/db-backups/apsviz.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- mv /data/db-backups/apsviz_cog_mosaic.dump.1 /data/db-backups/apsviz_cog_mosaic.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- mv /data/db-backups/dbglobals.sql.1 /data/db-backups/dbglobals.sql.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- mv /data/db-backups/apsviz_gauges.dump.1 /data/db-backups/apsviz_gauges.dump.1.sav
kubectl -n $DEST_NAMESPACE exec $DEST_POD -- mv /data/db-backups/ts_dbglobals.sql.1 /data/db-backups/ts_dbglobals.sql.1.sav

# copy the dump files to the destination
echo && echo "Copying the source backup files from local to the destination $DEST_NAMESPACE/$DEST_POD" && echo
kubectl -n $DEST_NAMESPACE --retries 10 cp ./backups/adcirc_obs.dump.1 $DEST_POD:/data/db-backups/adcirc_obs.dump.1
kubectl -n $DEST_NAMESPACE --retries 10 cp ./backups/asgs_dashboard.dump.1 $DEST_POD:/data/db-backups/asgs_dashboard.dump.1
kubectl -n $DEST_NAMESPACE --retries 10 cp ./backups/apsviz.dump.1 $DEST_POD:/data/db-backups/apsviz.dump.1
kubectl -n $DEST_NAMESPACE --retries 10 cp ./backups/apsviz_cog_mosaic.dump.1 $DEST_POD:/data/db-backups/apsviz_cog_mosaic.dump.1
kubectl -n $DEST_NAMESPACE --retries 10 cp ./backups/dbglobals.sql.1 $DEST_POD:/data/db-backups/dbglobals.sql.1
kubectl -n $DEST_NAMESPACE --retries 10 cp ./backups/apsviz_gauges.dump.1 $DEST_POD:/data/db-backups/apsviz_gauges.dump.1
kubectl -n $DEST_NAMESPACE --retries 10 cp ./backups/ts_dbglobals.sql.1 $DEST_POD:/data/db-backups/ts_dbglobals.sql.1

# alternative statements
#k -n eds --retries 10 cp ./adcirc_obs.dump.1 apsviz-supervisor-5bdcbd5d6c-ff78b:/data/db-backups/adcirc_obs.dump.1
#k -n eds --retries 10 cp ./asgs_dashboard.dump.1 apsviz-supervisor-5bdcbd5d6c-ff78b:/data/db-backups/asgs_dashboard.dump.1
#k -n eds --retries 10 cp ./apsviz.dump.1 apsviz-supervisor-5bdcbd5d6c-ff78b:/data/db-backups/apsviz.dump.1
#k -n eds --retries 10 cp ./apsviz_cog_mosaic.dump.1 apsviz-supervisor-5bdcbd5d6c-ff78b:/data/db-backups/apsviz_cog_mosaic.dump.1
#k -n eds --retries 10 cp ./dbglobals.sql.1 apsviz-supervisor-5bdcbd5d6c-ff78b:/data/db-backups/dbglobals.sql.1
#k -n $DEST_NAMESPACE --retries 10 cp ./backups/apsviz_gauges.dump.1 $DEST_POD:/data/db-backups/apsviz_gauges.dump.1
#k -n $DEST_NAMESPACE --retries 10 cp ./backups/ts_dbglobals.sql.1 $DEST_POD:/data/db-backups/ts_dbglobals.sql.1
