#!/bin/bash


# The script should be run with the after mount_smb has been successful. It takes no additional parameters.
remote_user = "owner"
declare -r mount=~/mnt
declare -r temp=~/tmp
declare -r megabyte=1000000
declare -r kilobyte=1000

declare -r osxdocuments="~/Documents"
declare -r osxdesktop="~/Desktop"
declare -r osxdownloads="~/Downloads"
declare -r osxpictures="~/Pictures"
declare -r osxmovies="~/Movies"
declare -r osxmusic="~/Music"

win10documents="/users/$remote_user/documents"
win10desktop="/users/$remote_user/desktop"
win10downloads="/users/$remote_user/downloads"
win10pictures="/users/$remote_user/documents"

if [[ ! -d "$mount"/$remote_user ]]; then

	# https://www.geeksforgeeks.org/du-command-linux-examples/
	# https://stackoverflow.com/questions/51715099/how-to-get-only-folder-size-from-du/51715324
	# local_size=$(du -sb --max-depth=0 ~/ | cut -f1)
	# target_size=$(du -sb --max-depth=0 ${mount}\${local_user} | cut -f1)
	mkdir "$mount"/$remote_user

fi

test=$(sudo du -s ~/ | awk '{print $1}')
control=$(sudo du -s ~/mnt | awk '{print $1}')
echo "test :" $(($test/$megabyte)) " KB"
echo "control :" $(($control/$megabyte)) " KB"

if [[ $test -gt $control ]]; then
	
	# https://www.ostechnix.com/the-mktemp-command-tutorial-with-examples-for-beginners/
	# https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps
	rsync --archive --progress --partial-dir="$temp" "$osxdocuments"/* "$mount"/"$remote_user"
	rsync --archive --progress --partial-dir="$temp" "$osxdesktop"/* "$mount"/"$remote_user"
	rsync --archive --progress --partial-dir="$temp" "$osxdownloads"/* "$mount"/"$remote_user"
	rsync --archive --progress --partial-dir="$temp" "$osxpictures"/* "$mount"/"$remote_user"
	rsync --archive --progress --partial-dir="$temp" "$osxmovies"/* "$mount"/"$remote_user"
	rsync --archive --progress --partial-dir="$temp" "$osxmusic"/* "$mount"/"$remote_user"
	sleep 5s
	echo "The local size is $((($test - $control)/$megabyte)) megabytes less than target"
	exit 0

else

	echo "The local size is $((($control - $test)/$megabyte)) megabytes greater than the target"
	exit 1

fi