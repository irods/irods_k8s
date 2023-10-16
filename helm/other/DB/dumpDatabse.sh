    #
    # backs up certain important databases.
    #
    # should be run as a cronjob nightly at midnight (local), e.g.
    # 0 21 * * * postgres /storage/backups.sh
    BASE_DIR=/data
    DUMPS_DIR=$BASE_DIR/db-backups

    if [ -e $LOG_PATH/export.log ]; then
        rm $LOG_PATH/export.log
    fi

    date >> $LOG_PATH/export.log

    pg_dumpall -h $IRODS_DB_HOST --globals-only | grep -v 'ROLE postgres' > dbglobals.sql

    for i in `psql -h $IRODS_DB_HOST -c "SELECT datname FROM pg_database where datname in ('')" | head -n -2 | tail -n +3`; do
        for j in {8..1}; do
            DUMP_FILE=$DUMPS_DIR/$i.dump.$j
            NEW_DUMP_FILE=$DUMPS_DIR/$i.dump.$(( j + 1 ))
            if [ -e $DUMP_FILE ]; then
                echo "mv $DUMP_FILE $NEW_DUMP_FILE" >> $LOG_PATH/export.log
                mv $DUMP_FILE $NEW_DUMP_FILE
            fi
        done
    done

    for i in `psql -h $IRODS_DB_HOST -c "SELECT datname FROM pg_database where datname in ('')" | head -n -2 | tail -n +3`; do
        if [ -e $DUMPS_DIR/$i.dump.8 ]; then
            echo "removing $DUMPS_DIR/$i.dump.8" >> $LOG_PATH/export.log
            rm $DUMPS_DIR/$i.dump.8
        fi
        echo "dumping...$DUMPS_DIR/$i.dump.1" >> $LOG_PATH/export.log
        date >> $LOG_PATH/export.log
        pg_dump -h $IRODS_DB_HOST -d $i -Fc -f $DUMPS_DIR/$i.dump.1
        date >> $LOG_PATH/export.log
    done

    exit 0
