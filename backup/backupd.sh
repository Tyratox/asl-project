#!/bin/bash

DIR_TO_BACKUP=$1
REMOTE_HOST=$2
REMOTE_DIR=$3
AFTER_CMD=$4

while true; do
    find $DIR_TO_BACKUP | entr -d sh -c "rsync -rltvh --chmod=ugo=rwX -e ssh $DIR_TO_BACKUP $REMOTE_HOST:$REMOTE_DIR;$AFTER_CMD"
done