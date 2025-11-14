#!/bin/bash

sudo mkdir -p /var/log/app

echo "created directory"

sudo su -c "echo 'Error: Something failed' > /var/log/app/app.log"
sudo su -c "echo 'Info: Started' > /var/log/app/info.log"
sudo su -c "echo 'Warning: High memory' > /var/log/app/debug.log"

touch -d "12 days ago" testfile.txt

touch -d "15 October" testfile2.log

touch -t 202511041430.00 oldfile.txt

for i in {1..5}; do
    touch -d "$((10 + i)) days ago 14:30" oldfile_$i.log
done

for i in {1..5}; do
    touch testfile_$i.txt
    touch -d "$((10 + i)) days ago" testfile_$i.txt
done
