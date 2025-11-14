#!/bin/bash

sudo mkdir -p /var/log/app
sudo touch /var/log/backup_script.log

echo "created directory"

sudo su -c "echo 'Error: Something failed' > /var/log/app/app.log"
sudo su -c "echo 'Info: Started' > /var/log/app/info.log"
sudo su -c "echo 'Warning: High memory' > /var/log/app/debug.log"

# create file using days back
touch -d "12 days ago" /var/log/app/testfile.txt 

# create file using particular date of a month
touch -d "15 October" /var/log/app/testfile2.log

# create file using particular date of a month
touch -t 202511041430.00 /var/log/app/oldfile.txt

# create multiple files using particular date of a month
for i in {1..5}; do
    touch -d "$((10 + i)) days ago 14:30" /var/log/app/oldfile_$i.log
done

for i in {1..5}; do
    touch /var/log/app/testfile_$i.txt
    touch -d "$((10 + i)) days ago" /var/log/app/testfile_$i.txt
done

