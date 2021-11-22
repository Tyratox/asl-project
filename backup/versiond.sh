#!/bin/bash

DIR_TO_VERSION=$1
VERSIONING_DIR=$2

inotifywait -r -m "$DIR_TO_VERSION" -e modify |
while read dir action file; do
    rsync -avh --backup --backup-dir=backup_`date +%F-%H-%M-%S` $DIR_TO_VERSION $VERSIONING_DIR
done