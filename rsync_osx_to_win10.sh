<<<<<<< HEAD

=======
<<<<<<< HEAD
destination=$1
local_user=$2
remote_user='guest'
share='public'

declare -r mount=~/mount
declare -r temp=~/temp
=======
target=$1
>>>>>>> 13c9777dff29694ee4b831b2bc561059d2e40461
remote_user=$2


declare -r mount=~/mnt
declare -r temp=~/tmp
>>>>>>> 4bec2d53de7d5489b477b5c5c6cb8ce431724fc8

declare -r osxdocuments=~/Documents
declare -r osxdesktop=~/Desktop
declare -r osxdownloads=~/Downloads
declare -r osxpictures=~/Pictures

win10documents="/users/${remote_user}/documents"
win10desktop="/users/${remote_user}/desktop"
win10downloads="/users/${remote_user}/downloads"
<<<<<<< HEAD
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
=======
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
>>>>>>> 4bec2d53de7d5489b477b5c5c6cb8ce431724fc8
		sleep 5s
		exit 0
	else
		echo "The local size is greater than the target"
		exit 1
	fi
else
<<<<<<< HEAD
	echo "mount directory already exists"
	exit 1
fi

echo "cp ${osxdocuments}/* ${mount}/${win10documents}"
echo "cp ${osxdesktop}/* ${mount}/${win10desktop}"
echo "cp ${osxdownloads}/* ${mount}/${win10downloads}"
echo "cp ${osxpictures}/* ${mount}/${win10pictures}"
=======
	echo "mount folder does NOT exist"
	exit 1
fi
>>>>>>> 4bec2d53de7d5489b477b5c5c6cb8ce431724fc8
