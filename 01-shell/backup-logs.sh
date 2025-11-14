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

if [ $USER -ne 0 ]
then
    echo "need to excecute the script with admin right"
    exit 1
else
    echo "script is stareted excecuting"
fi