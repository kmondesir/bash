destination=$1
local_user=$2
remote_user='guest'
share='public'

declare -r mount=~/mount
declare -r temp=~/temp

declare -r osxdocuments=~/Documents
declare -r osxdesktop=~/Desktop
declare -r osxdownloads=~/Downloads
declare -r osxpictures=~/Pictures

win10documents="/users/${remote_user}/documents"
win10desktop="/users/${remote_user}/desktop"
win10downloads="/users/${remote_user}/downloads"
win10pictures="/users/${remote_user}/documents"

if [[ ! -d "${mount}/${local_user}" ]]; then

# https://stackoverflow.com/questions/51715099/how-to-get-only-folder-size-from-du/51715324
# local_size=$(du -b --max-depth=0 ~/ | cut -f1)
# target_size=$(du -b --max-depth=0 ${mount}\${local_user} | cut -f1)

	if [[ local_size < target_size ]]; then
		echo "Please type the password to your remote system and press ENTER:"
		read password
		mkdir ${mount}/${local_user}
		mount -t smbfs //${remote_user}:${password}@${destination}/${share} ${mount}/${local_user}
		# https://www.ostechnix.com/the-mktemp-command-tutorial-with-examples-for-beginners/
		tmp=$(mktemp -d ~/tmp)
		# https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps
		rsync --archive --progress --partial-dir=${tmp} ${osxdocuments}/* ${mount}/${local_user}/${local_user}	
		rsync --archive --progress --partial-dir=${tmp} ${osxdesktop}/* ${mount}/${local_user}/${local_user}
		rsync --archive --progress --partial-dir=${tmp} ${osxdownloads}/* ${mount}/${local_user}/${local_user}
		rsync --archive --progress --partial-dir=${tmp} ${osxpictures}/* ${mount}/${local_user}/${local_user}

		umount ${mount}/${local_user}
		sleep 5s
		rm -r ${mount}/${local_user}
		sleep 5s
		exit 0
	else
		echo "The local size is greater than the target"
		exit 1
	fi
else
	echo "mount directory already exists"
	exit 1
fi

echo "cp ${osxdocuments}/* ${mount}/${win10documents}"
echo "cp ${osxdesktop}/* ${mount}/${win10desktop}"
echo "cp ${osxdownloads}/* ${mount}/${win10downloads}"
echo "cp ${osxpictures}/* ${mount}/${win10pictures}"
