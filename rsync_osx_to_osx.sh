<<<<<<< HEAD


=======
<<<<<<< HEAD
destination=$1
local_user=$2
remote_user='guest'
share='public'

mount=~/mount

osxdocuments=~/Documents
osxdesktop=~/Desktop
osxdownloads=~/Downloads
osxpictures=~/Pictures

if [[ ! -d "${mount}/${local_user}" ]]; then
	echo "Please type the password to your remote system and press ENTER:"
	read password
	mkdir ${mount}/${local_user}
	mount -t smbfs //${remote_user}:${password}@${destination}/${share} ${mount}/${local_user}	
	
	cp -aRv ${osxdocuments}/* ${mount}/${local_user}/${local_user}	
	cp -aRv ${osxdesktop}/* ${mount}/${local_user}/${local_user}
	cp -aRv ${osxdownloads}/* ${mount}/${local_user}/${local_user}
	cp -aRv ${osxpictures}/* ${mount}/${local_user}/${local_user}
		
	umount ${mount}/${local_user}
	sleep 5s
	rm -r ${mount}/${local_user}
	sleep 5s
	exit 0
else
=======
>>>>>>> 13c9777dff29694ee4b831b2bc561059d2e40461
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

	if [[ true ]]; then

		# https://www.ostechnix.com/the-mktemp-command-tutorial-with-examples-for-beginners/
		
		# https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps
		rsync --archive --progress --partial-dir=${temp} ~/Documents/* ${mount}/${osx_documents}	
		rsync --archive --progress --partial-dir=${temp} ~/Desktop/* ${mount}/${osx_desktop}
		rsync --archive --progress --partial-dir=${temp} ~/Downloads/* ${mount}/${osx_downloads}
		rsync --archive --progress --partial-dir=${temp} ~/Pictures/* ${mount}/${osx_pictures}

		sleep 5s
		exit 0
	else
		echo "The local size is greater than the target"
		exit 1
	fi
else
	echo "mount folder does NOT exist"
>>>>>>> 4bec2d53de7d5489b477b5c5c6cb8ce431724fc8
	exit 1
fi