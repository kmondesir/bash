#!/bin/bash



target=$1
share=$2
admin=$3

usage() {

	cat <<END
			The script's usage is as follows 
			Mounts an smb share using the following syntax mount_cifs 10.3.4.2 '$C' 'CBW'
			CBW stands for chocolate boy wonder
			The position arguments are as follows:
			1: server
			2: share
			3: administrator account
			Using the read commmand the password will be entered at run time.
	END
}

declare -r mount=~/mnt

# For security purposes the Administrator password is read into the system during the mounting of the share
echo "Please type the password to your remote system and press ENTER:"
read -s password

if [[ $# = 0 ]]; then
	usage()
fi

if [[! grep -qs ${mount} /proc/mounts ]]; then
    if [[ ping -c 1 $target ]]; then 
        mount -t cifs -o username="$admin",password="$password" //"$target"/"$share" "${mount}"
        exit 0
    else
        echo "Host:$target is unreachable"
        exit 1
    fi
else
    echo "Share already mounted"
    exit 1
fi
