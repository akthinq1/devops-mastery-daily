# !/bin/bash

# source dir
# destination dir
# log file with time stamps
# find dircetories are available or not
#  if not create dir
#  archive the log file and move to destination
# after move, delete all old file which are not required

##########################################################
# Log Backup Script
# Author: Anil
# Date: 14Nov2024
# Features:
# - Colors
# - Error handling
# - Compression
# - Logging
# - Parameter support
# - Retention Clenup
##########################################################

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

USER=$(id -u)

SOURCE_DIR="/var/log/app"
DESTINATION_DIR="/opt/backups"
RETENTION_DAYS=7
LOG_FILE="/var/log/backup_script.log"

# check user is admin or not
if [ $USER -ne 0 ];
then
    echo -e "${RED}need to excecute the script with admin rights${RESET}"
    exit 1
else
    echo -e "${GREEN}script is stareted excecuting...${RESET}"
fi

#  check override parameters are passed or not
if [ ! -z $1 ];
then 
    SOURCE_DIR=$1;
fi

if [ ! -z $2 ];
then 
    DESTINATION_DIR=$2;
fi

if [ ! -z $3 ];
then 
    RETENTION_DAYS=$3;
fi

# Time stamps
TIME=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="logs_$TIME.tar.gz"

# confirm backup started
echo -e "${YELLOW}Starting Log Backup...${RESET}" | tee -a $LOG_FILE

# check source directory is exist or not
if [ ! -d $SOURCE_DIR ];
then
    echo -e "${RED}ERROR: Source directory does not exist: $SRC_DIR${RESET}" | tee -a $LOG_FILE
    exit 1
fi

# check destination directory is exist or not
if [ ! -d $DESTINATION_DIR ];
then
    echo -e "${RED}ERROR: Destination directory does not exist: $DESTINATION_DIR${RESET}" | tee -a $LOG_FILE
    echo -e "${YELLOW}creating destination directory $DESTINATION_DIR...${RESET}" | tee -a $LOG_FILE
    mkdir -p $DESTINATION_DIR
fi

# create backup
tar -czf $DESTINATION_DIR/$BACKUP_FILE $SOURCE_DIR &>>$LOG_FILE
if[ $? -ne 0 ];
then 
    echo -e "${RED}ERROR: Backup failed.${RESET}" | tee -a $LOG_FILE
    exit 1
else
    echo -e "${GREEN}Backup successful: $BACKUP_DIR/$BACKUP_FILE${RESET}" | tee -a $LOG_FILE
fi

# Delete old backups
find "$SOURCE_DIR" -type f -name "*.log" -mtime +$RETENTION_DAYS -delete
# find "$SOURCE_DIR" -type f -name "*.log" -mtime +$RETENTION_DAYS -exec rm {} \

echo -e "${YELLOW}Old logs cleaned (>$RETENTION_DAYS days).${RESET}" | tee -a $LOG_FILE

echo -e "${GREEN}Backup complete.${RESET}" | tee -a $LOG_FILE
exit 0