#!/bin/bash


# Mounts an smb share using the following syntax mount_smb 10.3.4.2 $C CBW
target=$1
share=$2
admin=$3

mount=~/mnt

# For security purposes the Administrator password is read into the system during the mounting of the share
echo "Please type the password to your remote system and press ENTER:"
read -s password

if ! grep -q $mount 
    mount -t smbfs //${admin}:${password}@${target}/${share} ${mount}
    exit 0
else
    echo "Share already mounted"
    exit 1
fi