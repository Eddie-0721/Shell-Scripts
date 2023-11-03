#!/bin/bash

BACKUP_DIR=$(pwd)
MYSQL_USER="quant"
MYSQL_PASSWORD="quant"
DATABASE_1="investor"
DATABASE_2="helowin"
DATE=$(date +%Y%m%d)

mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $DATABASE_1 > $BACKUP_DIR/$DATABASE_1-$DATE.sql
echo "time: $(date +%Y-%m-%d-%H:%M:%S)"
echo "back database $DATABASE_1" 

mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD $DATABASE_2 > $BACKUP_DIR/$DATABASE_2-$DATE.sql
echo "time: $(date +%Y-%m-%d-%H:%M:%S)"
echo "back database $DATABASE_2"