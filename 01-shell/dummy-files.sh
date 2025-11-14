#!/bin/bash

sudo mkdir -p /var/log/app

echo "created directory"

sudo su -c "echo 'Error: Something failed' > /var/log/app/app.log"
sudo su -c "echo 'Info: Started' > /var/log/app/info.log"
sudo su -c "echo 'Warning: High memory' > /var/log/app/debug.log"