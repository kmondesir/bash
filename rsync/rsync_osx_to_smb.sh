#!/bin/bash


# The script should be run with the after mount_smb has been successful. It takes no additional parameters.
remote_user="owner"
declare -r mount=~/mnt
declare -r temp=~/tmp
declare -r megabyte=1000000
declare -r kilobyte=1000

declare -r osxdocuments=~/Documents
declare -r osxdesktop=~/Desktop
declare -r osxdownloads=~/Downloads
declare -r osxpictures=~/Pictures
declare -r osxmovies=~/Movies
declare -r osxmusic=~/Music

mnt_documents="${mount}/$remote_user/documents"
mnt_desktop="${mount}/$remote_user/desktop"
mnt_downloads="${mount}/$remote_user/downloads"
mnt_pictures="${mount}/$remote_user/pictures"
mnt_movies="${mount}/$remote_user/movies"
mnt_music="${mount}/$remote_user/music"

# test variable represents the source folder size
test=$(sudo du -s ~/ | awk '{print $1}')
# control variable represents the target folder size
control=$(sudo du -s ~/mnt | awk '{print $1}')

echo "test :" $(($test/$megabyte)) " KB"
echo "control :" $(($control/$megabyte)) " KB"

# checks if the mnt/user folder exists, if not it creates the folder
if [[ ! -d "${mount}"/"$remote_user" ]]; then

	# https://www.geeksforgeeks.org/du-command-linux-examples/
	# https://stackoverflow.com/questions/51715099/how-to-get-only-folder-size-from-du/51715324
	
	mkdir "${mount}"/"$remote_user"
	echo "${mount}"/"$remote_user"
	mkdir "$mnt_documents"
	mkdir "$mnt_desktop"
	mkdir "$mnt_downloads"
	mkdir "$mnt_pictures"
	mkdir "$mnt_movies"
	mkdir "$mnt_music"

fi

echo "Temp Directory:" "${temp}" "OSX Documents:" "${osxdocuments}" "Mount Point: $mnt_documents"
# checks if source folder size is greater than target folder size
if [[ ! $test -gt $control ]]; then
	
	
	# https://www.ostechnix.com/the-mktemp-command-tutorial-with-examples-for-beginners/
	# https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps
	rsync --archive --progress --partial-dir="${temp}" "${osxdocuments}"/* "$mnt_documents"
	rsync --archive --progress --partial-dir="${temp}" "${osxdesktop}"/* "$mnt_desktop"
	rsync --archive --progress --partial-dir="${temp}" "${osxdownloads}"/* "$mnt_downloads"
	rsync --archive --progress --partial-dir="${temp}" "${osxpictures}"/* "$mnt_pictures"
	rsync --archive --progress --partial-dir="${temp}" "${osxmovies}"/* "$mnt_movies"
	rsync --archive --progress --partial-dir="${temp}" "${osxmusic}"/* "$mnt_music"
	sleep 5s
	umount "${mount}"
	echo "The local size is $((($test - $control)/$megabyte)) megabytes less than target"
	exit 0

else

	echo "The local size is $((($control - $test)/$megabyte)) megabytes greater than the target"
	exit 1

fi