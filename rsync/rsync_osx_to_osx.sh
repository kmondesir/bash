#!/bin/bash


# The script should be run with the following syntax: copy_osx_to_osx.sh 'remote'
# The position arguments are as follows
# 1: name of the user
# No other arguments are required. This script should be run after the successful completion of mount_smb.
remote_user=$1

declare -r mount=~/mnt
declare -r temp=~/tmp
declare -r megabyte=1000000
declare -r kilobyte=1000

if [[ true ]]; then

# https://stackoverflow.com/questions/51715099/how-to-get-only-folder-size-from-du/51715324

# test variable represents the source folder size
test=$(sudo du -s ~/ | awk '{print $1}')
# control variable represents the target folder size
control=$(du -s ~/mnt | awk '{print $1}')

echo "test :" $(($test/$megabyte)) " KB"
echo "control :" $(($control/$megabyte)) " KB"

	if [[ $test -gt $control ]]; then
		# https://www.linuxquestions.org/questions/programming-9/bash-script-calculate-directory-size-698692/
		# https://www.ostechnix.com/the-mktemp-command-tutorial-with-examples-for-beginners/
		
		# https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps
		rsync --archive --progress --partial-dir="${temp}" ${~/Documents} "$mount"/"$remote_user"	
		rsync --archive --progress --partial-dir="${temp}" ${~/Desktop} "$mount"/"$remote_user"
		rsync --archive --progress --partial-dir="${temp}" ${~/Downloads} "$mount"/"$remote_user"
		rsync --archive --progress --partial-dir="${temp}" ${~/Pictures} "$mount"/"$remote_user"
		rsync --archive --progress --partial-dir="${temp}" ${~/Movies} "$mount"/"$remote_user"
		rsync --archive --progress --partial-dir="${temp}" ${~/Music} "$mount"/"$remote_user"

		"The local size is $((($test - $control)/$megabyte)) megabytes less than target"
		sleep 5s
		exit 0
	else
		echo "The local size is $((($control - $test)/$megabyte)) megabytes greater than the target"
		exit 1
	fi
else
	echo "mount folder does NOT exist"
	exit 1
fi
