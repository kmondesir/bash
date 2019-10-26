#!/bin/bash


remote_user=$1

declare -r mount=~/mnt
declare -r temp=~/tmp

osx_documents="/Users/${remote_user}/Documents"
osx_desktop="/Users/${remote_user}/Desktop"
osx_downloads="/Users/${remote_user}/Downloads"
osx_pictures="/Users/${remote_user}/Pictures"

if [[ -d "${mount}" ]]; then

# The script should be run with the following syntax: copy_osx_to_osx.sh 'remote'

# https://stackoverflow.com/questions/51715099/how-to-get-only-folder-size-from-du/51715324
# local_size=$(du -sb --max-depth=0 ~/ | cut -f1)
# target_size=$(du -sb --max-depth=0 ${mount}\${local_user} | cut -f1)

test=$(du -bs ~/ | awk '{print $1}')
control=$(du -bs ~/mnt | awk '{print $1}')
echo $test
echo $control

	if [[ $test -gt $control ]]; then
		# https://www.linuxquestions.org/questions/programming-9/bash-script-calculate-directory-size-698692/
		# https://www.ostechnix.com/the-mktemp-command-tutorial-with-examples-for-beginners/
		
		# https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps
		rsync --archive --progress --partial-dir=${temp} ~/Documents/* ${mount}/${osx_documents}	
		rsync --archive --progress --partial-dir=${temp} ~/Desktop/* ${mount}/${osx_desktop}
		rsync --archive --progress --partial-dir=${temp} ~/Downloads/* ${mount}/${osx_downloads}
		rsync --archive --progress --partial-dir=${temp} ~/Pictures/* ${mount}/${osx_pictures}

		sleep 5s
		exit 0
	else
		echo "The source size is greater than the target"
		exit 1
	fi
else
	echo "mount folder does NOT exist"
	exit 1
fi