#!/bin/bash



target=$1
share=$2
admin=$3

# usage() {

# cat <<- _END_
# 			The script's usage is as follows 
# 			Mounts an smb share using the following syntax mount_cifs 10.3.4.2 '$C' 'CBW'
# 			CBW stands for chocolate boy wonder
# 			The position arguments are as follows:
# 			1: server
# 			2: share
# 			3: administrator account
#			If a password is required you will be prompted for it at execution time. 
# _END_
# }

declare -r home=~
declare -r mount=${home}/mnt

# if [[ $# = 0 ]]; then
# 	usage()
# fi

# https://unix.stackexchange.com/questions/192273/which-partition-is-mounted-to-where 
if ! mount | grep 'smbfs' > /dev/null ; then
    if ping -c 1 $target > /dev/null ; then 
        mount -t smbfs "//$admin@$target/$share" "${mount}"
        exit 0
    else
        echo "Host:$target is unreachable"
        exit 1
    fi
else
    echo "Share already mounted"
    exit 1
fi
