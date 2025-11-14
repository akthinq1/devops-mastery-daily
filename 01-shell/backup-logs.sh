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

SOURCE_DIR="var/log/app"
DESTINATION_DIR="opt/backups"
RETENTION_DAYS=7
LOG_FILE="var/log/backup_script.log"

# check user is admin or not
if [ $USER -ne 0 ];
then
    echo "need to excecute the script with admin right"
    exit 1
else
    echo "script is stareted excecuting"
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