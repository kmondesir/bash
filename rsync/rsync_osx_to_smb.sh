#!/bin/bash


# The script should be run with the after mount_smb has been successful. It takes no additional parameters.
remote_user=$1

declare -r home=~
declare -r mount=${home}/mnt
declare -r temp=${home}/tmp

# Variables containing values for directory size calculations
declare -r megabyte=1000000
declare -r kilobyte=1000

# Variables for the locations of various user profile folders
declare -r osxdocuments="${home}/Documents"
declare -r osxdesktop="${home}/Desktop"
declare -r osxdownloads="${home}/Downloads"
declare -r osxpictures="${home}/Pictures"
declare -r osxmovies="${home}/Movies"
declare -r osxmusic="${home}/Music"

# test variable represents the source folder size
test=$(sudo du -s ${home} | awk '{print $1}')
# control variable represents the target folder size
control=$(sudo du -s ${mount} | awk '{print $1}')

echo "test :" $(($test/$megabyte)) " KB"
echo "control :" $(($control/$megabyte)) " KB"

# checks if the mnt/user folder exists, if not it creates the folder
if [[ ! -d "${mount}"/"$remote_user" ]]; then

	# https://www.geeksforgeeks.org/du-command-linux-examples/
	# https://stackoverflow.com/questions/51715099/how-to-get-only-folder-size-from-du/51715324
	
	mkdir "${mount}"/"$remote_user"
	echo "${mount}"/"$remote_user"

fi

echo "Temp Directory:" "${temp}" "OSX Documents:" "${osxdocuments}" "Mount Point: $mount/$remote_user"
# checks if source folder size is greater than target folder size
if [[ ! $test -gt $control ]]; then
	
	
	# https://www.ostechnix.com/the-mktemp-command-tutorial-with-examples-for-beginners/
	# https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps
	rsync --archive --compress --progress --partial-dir="${temp}" "${osxdocuments}" "${mount}"/"$remote_user"
	rsync --archive --compress --progress --partial-dir="${temp}" "${osxdesktop}" "${mount}"/"$remote_user"
	rsync --archive --compress --progress --partial-dir="${temp}" "${osxdownloads}" "${mount}"/"$remote_user"
	rsync --archive --compress --progress --partial-dir="${temp}" "${osxpictures}" "${mount}"/"$remote_user"
	rsync --archive --compress --progress --partial-dir="${temp}" "${osxmovies}" "${mount}"/"$remote_user"
	rsync --archive --compress --progress --partial-dir="${temp}" "${osxmusic}" "${mount}"/"$remote_user"
	sleep 5s
	umount "${mount}"
	echo "The local size is $((($test - $control)/$megabyte)) megabytes less than target"
	exit 0

else

	echo "The local size is $((($control - $test)/$megabyte)) megabytes greater than the target"
	exit 1

fi
