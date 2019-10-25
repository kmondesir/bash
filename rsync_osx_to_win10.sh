
remote_user=$2


declare -r mount=~/mnt
declare -r temp=~/tmp

declare -r osxdocuments=~/Documents
declare -r osxdesktop=~/Desktop
declare -r osxdownloads=~/Downloads
declare -r osxpictures=~/Pictures

win10documents="/users/${remote_user}/documents"
win10desktop="/users/${remote_user}/desktop"
win10downloads="/users/${remote_user}/downloads"
win10pictures="/users/${remote_user}/pictures"

if [[ -d "${mount}" ]]; then

# The script should be run with the following syntax: copy_osx_to_win10.sh '10.19.0.1' 'remote' 'C$' 'admin'

# https://stackoverflow.com/questions/51715099/how-to-get-only-folder-size-from-du/51715324
# local_size=$(du -sb --max-depth=0 ~/ | cut -f1)
# target_size=$(du -sb --max-depth=0 ${mount}\${local_user} | cut -f1)

	if [[ true ]]; then
		
		# https://www.ostechnix.com/the-mktemp-command-tutorial-with-examples-for-beginners/
		
		# https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps
		rsync --archive --progress --partial-dir=${temp} ${osxdocuments}/* ${mount}/${win10desktop}	
		rsync --archive --progress --partial-dir=${temp} ${osxdesktop}/* ${mount}/${win10desktop}
		rsync --archive --progress --partial-dir=${temp} ${osxdownloads}/* ${mount}/${win10documents}
		rsync --archive --progress --partial-dir=${temp} ${osxpictures}/* ${mount}/${win10pictures}

		umount ${mount}
		sleep 5s
		exit 0
	else
		echo "The local size is greater than the target"
		exit 1
	fi
else
	echo "mount folder does NOT exist"
	exit 1
fi